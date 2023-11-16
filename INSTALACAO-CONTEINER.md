# Instalação do CKAN em ambiente de contêineres

A instalação e configuração de um ambiente de contêineres como o Kubernetes está fora do escopo deste guia.
Assume-se que tal ambiente já existe no órgão e que o leitor está familiarizado com os conceitos de contêineres e com os comandos da plataforma que usa.

A estrutura adotada na CGU utiliza o PostgreSQL em uma máquina virtual e os demais serviços em contêineres gerenciados pelo Kubernetes.

A arquitetura da aplicação fica, portanto, com 4 serviços:
* CKAN uWSGI: vai responder as requisições HTTP
* CKAN worker: processa tarefas em background
* Solr: índice de busca
* Redis: armazena sessões, filas, entre outros

## Contêineres

### CKAN

Os dois serviços do CKAN usam a mesma imagem, que contém o Python e código da aplicação. O Dockerfile desta desta imagem está na pasta docker/ckan.

Por padrão a imagem inicia o processo do uWSGI. Se quiser iniciar o processo do `worker`, passe como comando para a imagem a palavra `worker`.

O contêiner uWSGI responde as requisições HTTP na porta 8080.

Os contêineres do CKAN precisam de um volume persistente montado no caminho `/var/lib/ckan/default`.
A pasta montada nesse caminho deve ter permissão de escrita para o usuário com ID 900. Esse UID é do usuário que roda o processo principal do CKAN.

### Solr

O Solr não precisa de uma imagem customizada, podendo ser utilizada diretamente a imagem do DockerHub na versão 8 (`solr:8`).

Este contêiner precisa de um volume persistente montado no caminho `/var/solr`.
A pasta montada nesse caminho deve ter permissão de escrita para o usuário com ID 8983. Esse UID é do usuário que roda o processo principal do Solr.

### Redis

O Redis também não precisa de uma imagem customizada, podendo ser utilizada diretamente a image do DockerHub (`redis:latest`).

Este contêiner não precisa de volumes, pois os dados não serão persistidos.

## Docker Compose

A pasta docker contém o arquivo `docker-compose.yml` como referência para as configurações dos serviços em um ambiente de contêineres.

Este arquivo também conta com o PostgreSQL em contêiner, mas apenas para teste. Não recomendamos usar o PostgreSQL em contêiner.

Para poder testar os contêineres, use os comandos abaixo:

```sh
cd docker
docker compose build
docker compose up
```

## Configuração do PostgreSQL

Se estiver usando o Docker Compose para testar, não é preciso configurar nada no PostgreSQL.

Se estiver configurando um ambiente de uso real, crie um um usuário para a aplicação e um banco de dados com a codificação UTF-8.
Essas credenciais devem constar na configuração do CKAN conforme mostrado na sequência deste documento.

## Configuração do Solr

Crie o índice que o CKAN irá utilizar executando os seguintes comandos dentro do contêiner do Solr:

```sh
solr create -c ckan
wget -O /var/solr/data/ckan/conf/managed-schema https://raw.githubusercontent.com/ckan/ckan/ckan-2.10.1/ckan/config/solr/schema.xml
```

Em seguida reinicie o contêiner.

## Configuração do Redis

O Redis não precisa de configurações adicionais.

## Configuração do CKAN

O arquivo de configuração usado pela imagem está em docker/ckan/ckan.ini.

Você pode modificá-lo diretamente e reconstruir a imagem. No entanto, não é recomendado incluir informações sensíveis na imagem (como a senha do banco de dados).
Algumas opções para mitigar esse problema são:
* Usar variáveis de ambiente: o CKAN lê diretamente **algumas** configurações por variáveis de ambiente. Veja em [Environment variables](https://docs.ckan.org/en/2.10/maintaining/configuration.html#environment-variables).
* Montar o arquivo ckan.ini dentro da imagem a partir de um objeto Secret do Kubernetes (https://kubernetes.io/docs/concepts/configuration/secret/) ou equivalente na plataforma utilizada pelo órgão.
* No Entrypoint da imagem (arquivo docker/ckan/ckan-entrypoint.sh), programar uma lógica que busca os valores sensíveis em um serviço de Vault (Ex: AWS Secrets Manager, Hashicorp Vault, entre outros) e os substituir no arquivo /etc/ckan/default/ckan.ini da imagem. Esta é a forma utilizada na CGU.

As principais configurações a serem modificadas estão marcadas com "ALTERAR ABAIXO" no arquivo ckan.ini e são mostradas a seguir:

```ini
# String aleatória usada na geração de hashes para sessões
beaker.session.secret = <<INSERIR STRING ALEATORIA>>

# URL de conexão com o Banco de Dados PostgreSQL
sqlalchemy.url = postgresql://ckan_user:password@postgresql_svc:5432/ckan_db

# URL do site
ckan.site_url = http://localhost:8080

# URL de conexão com o Solr
solr_url = http://solr_svc:8983/solr/ckan

# URL de conexão com o Redis
ckan.redis.url = redis://redis_svc:6379/0

# Título do Site
ckan.site_title = <<TITULO DO SITE>>
```

Para entender melhor as opções de configuração, consulte a documentação do CKAN em [Configuration Options](https://docs.ckan.org/en/2.10/maintaining/configuration.html).

Após alterar as configurações necessárias, inicialize o Banco de Dados do CKAN executando o seguinte comando dentro de algum dos contêineres CKAN:

```sh
ckan -c /etc/ckan/default/ckan.ini db init
```

Em seguida reinicie os contêineres CKAN.

Acesse a URL que aponta para o serviço do CKAN uWSGI e verifique se a página inicial carregou corretamente. Se estiver testando com o Docker Compose, a URL é simplesmente http://localhost:8080.

Crie um usuário administrador para a aplicação executando o seguinte comando dentro de um contêiner CKAN:

```sh
ckan -c /etc/ckan/default/ckan.ini sysadmin add <usuario> email=<email@dominio.com>
```

## HTTPS

O contêiner CKAN uWSGI, da forma como a imagem foi disponibilizada neste repositório, só responde em HTTP.

Para utilizar HTTPS no ambiente de produção é possível configurar o HTTPS no próprio contêiner.
Para isso, edite o arquivo [ckan-uwsgi.ini](docker/ckan/ckan-uwsgi.ini) e configure a opção `https` conforme orientação da documentação disponível em [HTTPS support](https://uwsgi-docs.readthedocs.io/en/latest/HTTPS.html).

No entanto, em ambiente de contêineres, o mais comum é que exista um Balanceador de Carga que distribui as requisições para os contêineres.
Neste caso, é mais indicado configurar o HTTPS no balanceador de carga, o que é conhecido como *SSL Offloading*. Esta é a forma utilizada pela CGU.
Esse tipo de configuração é altamente dependente da infra-estrutura do órgão e portanto não será detalhado neste guia.

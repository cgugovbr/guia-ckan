# Instalação do CKAN em servidor ou VM dedicada

Copie a pasta `vm` deste repositório para o servidor em questão. Em seguida execute o script de instalação como super usuário:

```sh
cd vm
sudo ./instalar.sh
```

O script irá instalar os seguintes serviços:
* CKAN - Aplicação Python
* uWSGI - Gateway do Web Server
* Nginx - Web Server
* Supervisor - Monitor de processos

Ao final será perguntado se o usuário quer instalar na mesma máquina os seguintes serviços adicionais:
* Redis
* Apache Solr
* PostgreSQL

Conforme dito anteriormente, esses serviços podem ser instalados no mesmo servidor ou em servidores separados.
A instalação na mesma máquina simplifica a configuração. 
Recomendamos instalar ao menos o Redis na mesma máquina do CKAN, uma vez que ele não consome muitos recursos.
Para instalar em servidores separados responda não para as perguntas correspondentes. Utilize o script no servidor adequado passando como argumento o sistema a ser instalado.

```sh
# Para instalar apenas o Redis
sudo ./instalar.sh redis

# Para instalar apenas o Solr
sudo ./instalar.sh solr

# Para instalar apenas o PostgreSQL
sudo ./instalar.sh postgresql
```

Lembre-se de configurar as permissões de rede e firewall adequadas para a correta comunicação com o CKAN.
A seguir está a lista de portas padrão utilizadas pelos serviços:

| Serviço    | Porta Padrão |
|------------|--------------|
| Redis      | 6379         |
| Solr       | 8983         |
| PostgreSQL | 5432         |

## Configuração do PostgreSQL

Crie um usuário chamado `ckan_user` bem como uma base dados `ckan_db` usando a codificação UTF-8.
Como exemplo, use os comandos abaixo na máquina do servidor que roda o banco de dados:

```sh
sudo -u postgres createuser -S -D -R -P ckan_user
sudo -u postgres createdb -O ckan_user -E utf-8 ckan_db
```

Por padrão o PostgreSQL só permite conexões locais. Se você instalou o PostgreSQL em um servidor separado do CKAN ou vai rodar o CKAN em contêiner, você precisará fazer o seguinte:
* Editar o parâmetro `listen_addresses` do arquivo `postgresql.conf` para indicar a interface de rede que o servidor vai se comunicar. Veja mais em [Connection Settings](https://www.postgresql.org/docs/14/runtime-config-connection.html#GUC-LISTEN-ADDRESSES).
* Editar o arquivo `pg_hba.conf` para permitir conexões de outro host. Veja mais em [The pg\_hba.conf file](https://www.postgresql.org/docs/14/auth-pg-hba-conf.html).

## Configuração do Solr

Crie o índice que o CKAN irá utilizar executando os seguintes comandos:

```sh
sudo -u solr /opt/solr/bin/solr create -c ckan
sudo -u solr wget -O /var/solr/data/ckan/conf/managed-schema https://raw.githubusercontent.com/ckan/ckan/ckan-2.10.1/ckan/config/solr/schema.xml
sudo systemctl restart solr
```

## Configuração do Redis

Por padrão o Redis também só permite conexões locais. Se você instalou o Redis na mesma máquina do CKAN, não precisa fazer nada.

Se você instalou o Redis em outra máquina, será preciso configurá-lo para aceitar conexões de outro host. Edite o arquivo `/etc/redis/redis.conf` e modifique o seguinte:
* Altere a diretiva `bind` para incluir o endereço da interface de rede que o servidor vai se comunicar.
* Defina uma senha para conexão na diretiva `requirepass`.

Para mais informações sobre segurança e autenticação no Redis consulte a documentação em [Redis Security](https://redis.io/docs/management/security/).

## Configuração do CKAN

O arquivo de configuração principal do CKAN fica em `/etc/ckan/default/ckan.ini`.

Copie o exemplo disponibilizado em `vm/ckan.ini` e modifique principalmente os parâmetros marcados com "ALTERAR ABAIXO":

```ini
# String aleatória usada na geração de hashes para sessões
beaker.session.secret = <<INSERIR STRING ALEATORIA>>

# URL de conexão com o Banco de Dados PostgreSQL
sqlalchemy.url = postgresql://ckan_user:password@localhost:5432/ckan_db

# URL do site
ckan.site_url = http://localhost

# URL de conexão com o Solr
solr_url = http://localhost:8983/solr/ckan

# URL de conexão com o Redis
ckan.redis.url = redis://localhost:6379/0

# Título do Site
ckan.site_title = <<TITULO DO SITE>>
```

Para entender melhor as opções de configuração, consulte a documentação do CKAN em [Configuration Options](https://docs.ckan.org/en/2.10/maintaining/configuration.html).

Após alterar as configurações, inicialize as tabelas do banco de dados do CKAN e reinicialize a aplicação executando:

```sh
sudo ckan db init
sudo systemctl restart supervisor nginx
```

Acesse a URL que aponta para o servidor do CKAN e verifique se a página inicial carregou corretamente.

Crie um usuário administrador para a aplicação usando o seguinte comando:

```sh
sudo ckan sysadmin add <usuario> email=<email@dominio.com>
```

## HTTPS

Por enquanto o sistema só está funcionando em HTTP, mas para colocá-lo em produção é preciso configurar o HTTPS.

Antes de tudo, o órgão precisa providenciar um certificado SSL válido para o domíno do site.
Caso esteja apenas fazendo um teste, é possível gerar um certificado auto-assinado usando o comando abaixo:

```sh
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
```

Atenção! Este certificado auto-assinado NÃO pode ser usado em produção.

Em seguida, é preciso configurar o Nginx, que é o servidor web instalado anteriormente.
Edite o arquivo `/etc/nginx/sites-available/ckan` para incluir as seguintes diretivas no bloco `server`, editando os valores:

```
server {
    ...
    listen              443 ssl;
    server_name         ckan.dominio-do-orgao.gov.br;
    ssl_certificate     /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ...
}
```

`server_name` é o domínio do site, `ssl_certificate` indica o caminho para o arquivo do certificado e `ssl_certificate_key` indica o caminho para o arquivo da chave privada do certificado.

Consulte mais detalhes sobre essa configuração do Nginx em [Configuring HTTPS servers](https://nginx.org/en/docs/http/configuring_https_servers.html).

Também é interessante configurar o Nginx para redirecionar as requisições HTTP para HTTPS.
Para isso adicione um novo bloco `server` no mesmo arquivo com o seguinte conteúdo:

```
server {
    listen 80;
    server_name _;
    return 302 https://$host$request_uri;
}
```

Em seguida, reinicie o servidor Nginx e teste:

```sh
sudo systemctl restart nginx
```

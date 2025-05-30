# Guia de Instalação e Configuração do CKAN

**Autor:** Controladoria-Geral da União (CGU)

**Atualizado em:** maio/2025

## Introdução

CKAN (https://ckan.org) é um software livre e gratuito para portais de dados.

A documentação de referência do CKAN pode ser acessada em https://docs.ckan.org.

Este repositório reúne instruções para instalação e configuração do CKAN para uso como portal de divulgação de dados abertos no âmbito de qualquer órgão da administração pública. O documento também contém orientações para melhor integração do portal CKAN do órgão com o Portal de Dados Abertos do Governo Federal (https://dados.gov.br).

É importante salientar que quando se acessa a URL https://dados.gov.br, o que é exibido não é o CKAN, mas sim um sistema desenvolvido pela CGU que utiliza o CKAN por trás.
No entanto, é perfeitamente possível utilizar apenas o CKAN.

## Requisitos e Tecnologia

A versão do CKAN considerada neste guia é a **2.10.1**, a mais recente disponível no momento da produção deste conteúdo.

### Ambiente da aplicação

Para execução do CKAN é necessário disponibilizar um servidor dedicado ou máquina virtual Linux 64-bits com Ubuntu 20.04 ou 22.04. Outras distribuições também funcionam, porém as instruções de instalação não serão detalhadas neste guia.

Como alternativa, também é possível usar um ambiente de execução de contêineres como o Kubernetes (https://kubernetes.io/). Esta é a forma utilizada na CGU.

A aplicação necessita do Python 3.7 ou mais recente instalados.

### Sistemas auxiliares

Além do servidor de aplicação são necessários os seguintes sistemas:
* Banco de Dados PostgreSQL na versão mínima 9.5. A CGU usa a versão 14.7.
* Sistema de Pesquisa Apache Solr na versão 8.
* Banco de Dados Redis

Os sistemas podem ser instalados no mesmo servidor/VM de aplicação ou em máquinas separadas, de acordo com os recursos e políticas de cada órgão.

Na CGU, o PostgreSQL roda em uma máquina separada. O Redis e o Solr rodam em contêineres no Kubernetes.

## Instalação

Esta seção é voltada aos técnicos de TI do órgão e detalham as orientações e procedimentos para instalação do CKAN.

Serão detalhadas duas opções de instalação: usando servidores/VMs dedicados ou usando contêineres.
Acesse a seção que for mais adequada para a infra-estrutura existente no órgão.

[Opção 1 - servidor ou VM dedicada](INSTALACAO-VM.md)

[Opção 2 - contêineres](INSTALACAO-CONTEINER.md)

## Integração com o portal dados.gov.br

Tendo o CKAN instalado no órgão, os dados inseridos podem ser automaticamente sincronizados com o Portal de Dados Abertos do Governo Federal.

Para que isso ocorra, não é necessária modificação alguma na instalação do CKAN do órgão. A configuração é feita no próprio Portal do Governo Federal.

Para entender melhor como os dados devem ser preenchidos no CKAN e como eles aparecem no Portal do Governo Federal consulte a seção [Preenchimento dos dados no CKAN](PREENCHIMENTO-CKAN.md).

De maneira alternativa, é possível integrar um sistema qualquer do órgão com o Portal de Dados Abertos sem
a necessidade de instalação de um sistema CKAN, bastanto que o sistema em questão consiga gerar um catálogo
de dados no formato DCAT-BR. Veja mais detalhes em [Integração DCAT-BR](INTEGRACAO-DCAT-BR.md).

### Observação Técnica

O Portal do Governo Federal busca os dados no CKAN do órgão através da API pública do CKAN. As chamadas dessa API são URLs que começam com `/api`.

Caso o órgão implemente alguma regra de firewall para bloquear o acesso de robôs às páginas do CKAN, a sincronização pode não acontecer corretamente.
Nesses casos, entre em contato com a CGU.

## Contato

Divisão de Prospecção de Soluções\
Controladoria-Geral da União (CGU)

disol@cgu.gov.br

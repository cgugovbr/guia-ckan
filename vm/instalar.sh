#!/bin/bash

# Função de log
log() {
  echo "[instalar.sh] $1"
}

# Ao acontecer algum erro, abortar script
error_handler() {
  log "Erro durante a instalação, abortando..."
  exit 1
}
trap error_handler ERR

# Verifica versão do Ubuntu
if ! command -v lsb_release > /dev/null; then
  log "Erro: Sistema Operacional não identificado"
  exit 1
fi
SO=$(lsb_release -i | cut -f2)
if [ $SO != "Ubuntu" ]; then
  log "Distribuição $SO não suportada"
  exit 1
fi
VERSAO=$(lsb_release -r | cut -f2)
if [ $VERSAO != "20.04" ] && [ $VERSAO != "22.04" ]; then
  log "Versão $VERSAO do Ubuntu não suportada"
  exit 1
fi

# Função para confirmar operação
confirmar() {
  local RESP
  read -p "$1 [s/n] " RESP
  if [ $RESP = "s" ] || [ $RESP = "S" ]; then
    return 0;
  else
    return 1;
  fi
}

# Funções de instalação
instalar_redis() {
  trap error_handler ERR
  log "Instalando o Redis"
  apt-get install -y redis-server
  log "Redis instalado"
}

instalar_solr() {
  trap error_handler ERR
  log "Instalando o Java"
  apt-get install -y openjdk-8-jdk
  log "Java instalado"

  log "Instalando o Solr"
  wget https://www.apache.org/dyn/closer.lua/lucene/solr/8.11.2/solr-8.11.2.tgz?action=download -O /tmp/solr-8.11.2.tgz
  tar -C /tmp -xf /tmp/solr-8.11.2.tgz solr-8.11.2/bin/install_solr_service.sh --strip-components=2
  /tmp/install_solr_service.sh /tmp/solr-8.11.2.tgz
  rm /tmp/solr-8.11.2.tgz /tmp/install_solr_service.sh
  log "Solr instalado"
}

instalar_postgresql() {
  trap error_handler ERR
  log "Instalando o PostgreSQL"
  apt-get install -y postgresql
  log "PostgreSQL instalado"
}

instalar_ckan() {
  trap error_handler ERR
  # Instalar dependências
  log "Instalando dependências"
  apt-get install -y libpq5 nginx supervisor
  log "Dependências instaladas"

  # Instalar CKAN
  log "Instalando o CKAN"
  if [ $VERSAO = "22.04" ]; then
    wget https://packaging.ckan.org/python-ckan_2.10-jammy_amd64.deb -O /tmp/ckan.deb
  else
    wget https://packaging.ckan.org/python-ckan_2.10-focal_amd64.deb -O /tmp/ckan.deb
  fi

  dpkg -i /tmp/ckan.deb
  rm /tmp/ckan.deb

  # Desabilita o datapusher
  rm -f /etc/supervisor/conf.d/ckan-datapusher.conf
  log "CKAN instalado"
}

# Processa argumentos
if [ $# -eq 0 ]; then
  instalar_ckan
  if confirmar "Deseja instalar o Redis nesta máquina?"; then
    instalar_redis
  fi
  if confirmar "Deseja instalar o Apache Solr nesta máquina?"; then
    instalar_solr
  fi
  if confirmar "Deseja instalar o PostgreSQL nesta máquina?"; then
    instalar_postgresql
  fi
else
  if [ $1 = "ckan" ]; then
    instalar_ckan
  elif [ $1 = "redis" ]; then
    instalar_redis
  elif [ $1 = "solr" ]; then
    instalar_solr
  elif [ $1 = "postgresql" ]; then
    instalar_postgresql
  else
    log "Argumento '$1' inválido"
    exit 1
  fi
fi

#!/bin/bash

######
# Implemente aqui alguma lógica de recuperação de segredos de um sistema de Vault
# e substitua os valores no arquivo ${CKAN_CONFIG}/ckan.ini
######

# Verifica se queremos rodar o Worker do CKAN ou o servidor HTTP
if [ "$1" = "worker" ]; then
  echo "Iniciando CKAN Worker"
  exec ${CKAN_VENV}/bin/ckan -c ${CKAN_CONFIG}/ckan.ini jobs worker
else
  echo "Iniciando CKAN uWSGI"
  exec ${CKAN_VENV}/bin/uwsgi -i ${CKAN_CONFIG}/ckan-uwsgi.ini
fi

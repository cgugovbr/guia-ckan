FROM debian:buster

# Instala pacotes necessários
RUN apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade \
    && apt-get -q -y install \
        python3-dev \
        python3-pip \
        python3-venv \
        libpq-dev \
        libxml2-dev \
        libxslt-dev \
        libgeos-dev \
        libssl-dev \
        libffi-dev \
        postgresql-client \
        build-essential \
        git-core \
    && apt-get -q clean

# Define variáveis
ENV CKAN_HOME /usr/lib/ckan
ENV CKAN_VENV $CKAN_HOME/venv
ENV CKAN_CONFIG /etc/ckan/default
ENV CKAN_STORAGE_PATH /var/lib/ckan/default

# Cria usuário para rodar processos
RUN useradd -r -u 900 -m -d $CKAN_HOME -s /bin/false ckan

# Cria virtual env para instalar o CKAN
RUN mkdir -p $CKAN_VENV $CKAN_CONFIG $CKAN_STORAGE_PATH && \
    python3 -m venv $CKAN_VENV && \
    ln -s $CKAN_VENV/bin/pip /usr/local/bin/ckan-pip &&\
    ln -s $CKAN_VENV/bin/ckan /usr/local/bin/ckan

# Instala o CKAN
RUN . $CKAN_VENV/bin/activate && \
    ckan-pip install -U pip && \
    ckan-pip install -e git+https://github.com/ckan/ckan@ckan-2.10.1#egg=ckan && \
    ckan-pip install --upgrade --no-cache-dir -r $CKAN_VENV/src/ckan/requirements.txt && \
    ln -s $CKAN_VENV/src/ckan/ckan/config/who.ini $CKAN_CONFIG/who.ini && \
    chown -R ckan:ckan $CKAN_HOME $CKAN_VENV $CKAN_CONFIG $CKAN_STORAGE_PATH

# Copia arquivo de configuração customizado
COPY --chown=ckan:ckan ckan.ini $CKAN_CONFIG/

# Instalando e configurando o uWSGI
RUN . ${CKAN_VENV}/bin/activate && \
    ckan-pip install uwsgi
COPY wsgi.py ckan-uwsgi.ini $CKAN_CONFIG/

# Copia entrypoint
COPY ckan-entrypoint.sh /
RUN chmod +x /ckan-entrypoint.sh

USER ckan

EXPOSE 8080

ENTRYPOINT ["/ckan-entrypoint.sh"]

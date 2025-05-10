FROM thecodingmachine/php:8.2-v4-apache-node18

# Troca para root para instalar dependências
USER root

# Atualiza sistema e define localidade
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        locales \
        git \
        unzip \
        zip \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libonig-dev \
        libxml2-dev \
        libzip-dev && \
    locale-gen pt_BR.UTF-8 && \
    update-locale LANG=pt_BR.UTF-8 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Variáveis de ambiente de localização
ENV LANG=pt_BR.UTF-8 \
    LANGUAGE=pt_BR:pt \
    LC_ALL=pt_BR.UTF-8

# Instala extensões PHP com script da imagem
RUN install-php-extensions gd zip intl xml opcache pdo_mysql mbstring

# Atualiza o Composer (caso queira a última versão)
RUN composer self-update

# Define o usuário padrão
USER docker

# Define o DocumentRoot do Apache
ENV APACHE_DOCUMENT_ROOT=public/

# Copie se necessário:
# COPY ./php.ini /usr/local/etc/php/conf.d/custom.ini
# COPY src/ /var/www/html/

# Base image
FROM php:8.1-apache

# Install system dependencies including gettext
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    mariadb-client \
    redis-server \
    gettext \
    libgettextpo-dev \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-install mysqli pdo pdo_mysql gettext

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]

# Note: Database and Redis server should be run as separate services/containers.

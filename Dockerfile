# Use the official PHP image as the base image
FROM php:8.2-cli

# Install dependencies required for building Open Swoole
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    libcurl4-openssl-dev \
    libssl-dev \
    libpcre3-dev \
    && docker-php-ext-install pdo_mysql \
    && apt-get clean

# Install Open Swoole via PECL
RUN pecl install openswoole \
    && docker-php-ext-enable openswoole

# Set the working directory in the container
WORKDIR /var/www/app

# Copy your application code into the container
COPY . .

# Expose the port that your Swoole app will run on (e.g., 9501)
EXPOSE 9501

# Set the default command to run your application
CMD ["php", "server.php"]

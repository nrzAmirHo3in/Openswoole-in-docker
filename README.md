# Openswoole-in-docker
 Installing Open Swoole in Docker involves creating a Dockerfile that sets up the environment, installs PHP, and adds Open Swoole. Here's how you can do it step-by-step.
## Steps to Install Open Swoole in Docker
##### 1. **Create a `Dockerfile`:** This file defines the environment for your application.

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

##### 2. **Create a PHP Script (e.g., `server.php`):** This script will use Open Swoole to run a basic HTTP server.
    <?php
    use Swoole\Http\Server;
    
    $server = new Server("0.0.0.0", 9501);
    
    $server->on("request", function ($request, $response) {
        $response->end("Hello, Open Swoole in Docker!");
    });
    
    $server->start();
##### 3. **Build the Docker Image:** Run the following command in the directory containing your `Dockerfile` and `server.php`:
    docker build -t openswoole-app .
##### 4. **Run the Docker Container:** After the image is built, you can run it:
    docker run -d -p 9501:9501 --name openswoole-app openswoole-app
##### 5. **Test the Open Swoole Server:** Open your browser or use `curl` to test the server:
    curl http://localhost:9501
##### You should see the response: `Hello, Open Swoole in Docker!`
---
##### This is how you can see running containers.
    docker ps -a
    

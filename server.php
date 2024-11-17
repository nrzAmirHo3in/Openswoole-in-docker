<?php
use Swoole\Http\Server;

$server = new Server("0.0.0.0", 9501);

$server->on("request", function ($request, $response) {
    $response->end("Hello, Open Swoole in Docker!");
});

$server->start();

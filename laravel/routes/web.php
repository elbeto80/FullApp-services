<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});


Route::get('/post', function () {
    return response()->json([
        [
            'id' => 1,
            'title' => '¿Qué es Laravel?',
            'body' => 'Laravel es un framework de PHP diseñado para desarrollar aplicaciones web de manera sencilla y elegante.',
        ],
        [
            'id' => 2,
            'title' => 'Ventajas de React',
            'body' => 'React permite construir interfaces de usuario interactivas y reutilizables, facilitando el desarrollo front-end.',
        ],
        [
            'id' => 3,
            'title' => '¿Qué es JSON?',
            'body' => 'JSON es un formato ligero de intercambio de datos, fácil de leer y escribir tanto para humanos como para máquinas.',
        ],
        [
            'id' => 4,
            'title' => 'Docker en Desarrollo',
            'body' => 'Docker permite crear entornos consistentes para el desarrollo y despliegue de aplicaciones.',
        ],
        [
            'id' => 5,
            'title' => '¿Para qué sirve Vite?',
            'body' => 'Vite es una herramienta de construcción rápida para proyectos modernos de front-end.',
        ],
        [
            'id' => 6,
            'title' => 'Instalando Composer',
            'body' => 'Composer es el gestor de dependencias para proyectos PHP, esencial para trabajar con Laravel.',
        ],
        [
            'id' => 7,
            'title' => '¿Qué es un API REST?',
            'body' => 'Un API REST permite la comunicación entre aplicaciones a través de peticiones HTTP usando métodos comunes.',
        ],
        [
            'id' => 8,
            'title' => '¿Qué es CORS?',
            'body' => 'CORS es un mecanismo que permite controlar desde qué dominios se pueden consumir recursos de un API.',
        ],
        [
            'id' => 9,
            'title' => 'Principios de MVC',
            'body' => 'El patrón MVC separa los datos, la lógica y la interfaz de usuario para facilitar el desarrollo y mantenimiento.',
        ],
        [
            'id' => 10,
            'title' => '¿Qué hace Axios?',
            'body' => 'Axios es una librería de JavaScript para realizar peticiones HTTP de manera sencilla desde el navegador o Node.js.',
        ],
        [
            'id' => 11,
            'title' => 'Versionado de Docker Compose',
            'body' => 'Docker Compose permite definir y correr múltiples contenedores con configuraciones versionadas en un solo archivo.',
        ],
        [
            'id' => 12,
            'title' => '¿Qué es una migración en Laravel?',
            'body' => 'Las migraciones en Laravel gestionan la estructura de la base de datos de forma controlada y repetible.',
        ],
        [
            'id' => 13,
            'title' => 'Los Middlewares en Laravel',
            'body' => 'Los middlewares permiten filtrar y procesar las peticiones HTTP antes de llegar al controlador.',
        ],
        [
            'id' => 14,
            'title' => 'Hooks en React',
            'body' => 'Los hooks permiten a los componentes funcionales de React gestionar estado y efectos secundarios.',
        ],
        [
            'id' => 15,
            'title' => 'Despliegue en producción',
            'body' => 'El despliegue en producción requiere buenas prácticas de seguridad, rendimiento y mantenimiento continuo.',
        ],
    ]);
});

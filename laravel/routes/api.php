<?php

use Illuminate\Support\Facades\Route;

Route::get('/health', function () {
    return response()->json([
        'status' => 'ok',
        'message' => 'Laravel backend is running!',
        'timestamp' => now()->toISOString()
    ]);
});

Route::get('/hello', function () {
    return response()->json([
        'message' => 'Hello from Laravel API!',
        'version' => app()->version()
    ]);
});

Route::get('/posts', function () {
    return response()->json([
        [
            'id' => 1,
            'title' => 'Cómo iniciar un proyecto en Laravel',
            'body' => 'Aprende a crear un nuevo proyecto usando el comando composer create-project y configura tu entorno de desarrollo.'
        ],
        [
            'id' => 2,
            'title' => 'React vs Vue: comparativa 2024',
            'body' => 'Analizamos las diferencias principales entre React y Vue para ayudarte a escoger el mejor framework para tu app web.'
        ],
        [
            'id' => 3,
            'title' => 'Introducción a Docker para desarrolladores',
            'body' => 'Descubre cómo dockerizar tu aplicación y simplifica el despliegue en cualquier entorno.'
        ],
        [
            'id' => 4,
            'title' => 'Guía rápida de Git Flow',
            'body' => 'Buenas prácticas para ramas, merges y releases usando Git Flow en equipos de desarrollo.'
        ],
        [
            'id' => 5,
            'title' => 'Automatiza tareas con GitHub Actions',
            'body' => 'Configura workflows para testeo, deploy y CI/CD en tus repositorios de GitHub.'
        ],
        [
            'id' => 6,
            'title' => 'Securizando APIs REST en Laravel',
            'body' => 'Implementa autenticación con Laravel Sanctum y protege rutas con middlewares.'
        ],
        [
            'id' => 7,
            'title' => 'Testing frontend con Jest',
            'body' => 'Escribe tests unitarios y de integración en proyectos JavaScript utilizando Jest.'
        ],
        [
            'id' => 8,
            'title' => 'Consumo de APIs externas con Axios',
            'body' => 'Ejemplos prácticos para consumir endpoints REST y manejar errores.'
        ],
        [
            'id' => 9,
            'title' => 'Optimización de rendimiento en aplicaciones web',
            'body' => 'Consejos para lazy loading, reducción de bundle y cache en frontend.'
        ],
        [
            'id' => 10,
            'title' => 'Crea tu propio paquete NPM',
            'body' => 'Paso a paso para estructurar, documentar y publicar tu librería JavaScript.'
        ],
        [
            'id' => 11,
            'title' => 'Buenas prácticas de código en PHP',
            'body' => 'Evita errores comunes y sigue estándares PSR para un código PHP limpio y mantenible.'
        ],
        [
            'id' => 12,
            'title' => 'Fundamentos de TypeScript para desarrolladores JavaScript',
            'body' => 'Integra tipado estático y recibe beneficios de autocompletado en tus proyectos JS.'
        ]
    ]);
});

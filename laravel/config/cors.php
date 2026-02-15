<?php

return [

  /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    */

  'paths' => ['api/*', 'sanctum/csrf-cookie', 'post', 'post/*'],

  'allowed_methods' => ['*'],

  'allowed_origins' => [
    'http://localhost:5173',
    'http://127.0.0.1:5173',
    'https://react.betocode.dev',
    'https://laravel.betocode.dev',
  ],

  'allowed_origins_patterns' => [],

  'allowed_headers' => ['*'],

  'exposed_headers' => [],

  'max_age' => 0,

  'supports_credentials' => false,

];

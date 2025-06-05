<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;

Route::get('/', function () {
    return view('welcome');
});

// Rota de debug temporária
Route::get('/debug', function () {
    return response()->json([
        'status' => 'ok',
        'app_env' => env('APP_ENV'),
        'app_debug' => env('APP_DEBUG'),
        'app_key_exists' => !empty(env('APP_KEY')),
        'db_connection' => env('DB_CONNECTION'),
        'db_host' => env('DB_HOST'),
        'php_version' => PHP_VERSION,
        'laravel_version' => app()->version(),
        'timestamp' => now()
    ]);
});

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

// Rotas protegidas por autenticação
Route::middleware(['auth'])->group(function () {
    // Rotas de usuários
    Route::resource('users', UserController::class);
});

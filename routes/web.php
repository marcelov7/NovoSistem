<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;

Route::get('/', function () {
    return view('welcome');
});

Auth::routes();

Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

// Rotas protegidas por autenticação
Route::middleware(['auth'])->group(function () {
    // Rotas de usuários
    Route::resource('users', UserController::class);
});

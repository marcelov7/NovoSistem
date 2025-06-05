@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0">{{ __('Dashboard') }} - NovoSistem</h4>
                </div>

                <div class="card-body">
                    @if (session('status'))
                        <div class="alert alert-success" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <h5>{{ __('Bem-vindo, ') }}{{ Auth::user()->name }}!</h5>
                            <p class="text-muted">Acesse os módulos do sistema através dos cards abaixo.</p>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Card Usuários -->
                        <div class="col-md-6 col-lg-4 mb-3">
                            <div class="card h-100 border-primary">
                                <div class="card-body text-center">
                                    <i class="fas fa-users fa-3x text-primary mb-3"></i>
                                    <h5 class="card-title">Usuários</h5>
                                    <p class="card-text">Gerenciar usuários do sistema</p>
                                    <a href="{{ route('users.index') }}" class="btn btn-primary">
                                        <i class="fas fa-arrow-right me-2"></i>Acessar
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Card Configurações -->
                        <div class="col-md-6 col-lg-4 mb-3">
                            <div class="card h-100 border-secondary">
                                <div class="card-body text-center">
                                    <i class="fas fa-cogs fa-3x text-secondary mb-3"></i>
                                    <h5 class="card-title">Configurações</h5>
                                    <p class="card-text">Configurações do sistema</p>
                                    <button class="btn btn-secondary" disabled>
                                        <i class="fas fa-lock me-2"></i>Em breve
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Card Relatórios -->
                        <div class="col-md-6 col-lg-4 mb-3">
                            <div class="card h-100 border-info">
                                <div class="card-body text-center">
                                    <i class="fas fa-chart-bar fa-3x text-info mb-3"></i>
                                    <h5 class="card-title">Relatórios</h5>
                                    <p class="card-text">Visualizar relatórios</p>
                                    <button class="btn btn-info" disabled>
                                        <i class="fas fa-lock me-2"></i>Em breve
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <hr class="my-4">

                    <div class="row">
                        <div class="col-md-12">
                            <h6 class="text-muted">Estatísticas Rápidas</h6>
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="border rounded p-3 text-center">
                                        <h4 class="text-primary">{{ \App\Models\User::count() }}</h4>
                                        <small class="text-muted">Total de Usuários</small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="border rounded p-3 text-center">
                                        <h4 class="text-success">1</h4>
                                        <small class="text-muted">Você está logado</small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="border rounded p-3 text-center">
                                        <h4 class="text-info">Laravel 12</h4>
                                        <small class="text-muted">Versão do Framework</small>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="border rounded p-3 text-center">
                                        <h4 class="text-warning">Vue 3</h4>
                                        <small class="text-muted">Frontend Framework</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

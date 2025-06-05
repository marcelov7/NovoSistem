@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">{{ __('Editar Usuário') }} - {{ $user->name }}</h4>
                    <a href="{{ route('users.index') }}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> {{ __('Voltar') }}
                    </a>
                </div>

                <div class="card-body">
                    <user-form-component 
                        action-url="{{ route('users.update', $user) }}"
                        redirect-url="{{ route('users.index') }}"
                        method="PUT"
                        :user-data="{{ $user->toJson() }}"
                    ></user-form-component>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection 
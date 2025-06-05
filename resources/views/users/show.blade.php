@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">{{ __('Detalhes do Usuário') }}</h4>
                    <div>
                        <a href="{{ route('users.edit', $user) }}" class="btn btn-warning">
                            <i class="fas fa-edit"></i> {{ __('Editar') }}
                        </a>
                        <a href="{{ route('users.index') }}" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> {{ __('Voltar') }}
                        </a>
                    </div>
                </div>

                <div class="card-body">
                    <user-details-component 
                        :user-data="{{ $user->toJson() }}"
                        edit-url="{{ route('users.edit', $user) }}"
                        delete-url="{{ route('users.destroy', $user) }}"
                        index-url="{{ route('users.index') }}"
                    ></user-details-component>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection 
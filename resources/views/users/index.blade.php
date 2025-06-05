@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">{{ __('Usuários') }}</h4>
                    <a href="{{ route('users.create') }}" class="btn btn-primary">
                        <i class="fas fa-plus"></i> {{ __('Novo Usuário') }}
                    </a>
                </div>

                <div class="card-body">
                    <users-list-component 
                        :users-data="{{ $users->toJson() }}"
                        users-url="{{ route('users.index') }}"
                        create-url="{{ route('users.create') }}"
                    ></users-list-component>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection 
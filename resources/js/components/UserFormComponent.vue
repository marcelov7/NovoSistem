<template>
  <div class="user-form">
    <form @submit.prevent="submitForm">
      <!-- Nome -->
      <div class="mb-3">
        <label for="name" class="form-label">Nome *</label>
        <input
          id="name"
          v-model="form.name"
          type="text"
          class="form-control"
          :class="{ 'is-invalid': errors.name }"
          required
        />
        <div v-if="errors.name" class="invalid-feedback">
          {{ errors.name[0] }}
        </div>
      </div>

      <!-- Email -->
      <div class="mb-3">
        <label for="email" class="form-label">Email *</label>
        <input
          id="email"
          v-model="form.email"
          type="email"
          class="form-control"
          :class="{ 'is-invalid': errors.email }"
          required
        />
        <div v-if="errors.email" class="invalid-feedback">
          {{ errors.email[0] }}
        </div>
      </div>

      <!-- Senha -->
      <div class="mb-3">
        <label for="password" class="form-label">
          Senha {{ isEditing ? '(deixe em branco para não alterar)' : '*' }}
        </label>
        <input
          id="password"
          v-model="form.password"
          type="password"
          class="form-control"
          :class="{ 'is-invalid': errors.password }"
          :required="!isEditing"
        />
        <div v-if="errors.password" class="invalid-feedback">
          {{ errors.password[0] }}
        </div>
      </div>

      <!-- Confirmar Senha -->
      <div class="mb-3">
        <label for="password_confirmation" class="form-label">
          Confirmar Senha {{ isEditing ? '' : '*' }}
        </label>
        <input
          id="password_confirmation"
          v-model="form.password_confirmation"
          type="password"
          class="form-control"
          :class="{ 'is-invalid': errors.password_confirmation }"
          :required="!isEditing && form.password"
        />
        <div v-if="errors.password_confirmation" class="invalid-feedback">
          {{ errors.password_confirmation[0] }}
        </div>
      </div>

      <!-- Botões -->
      <div class="d-flex justify-content-between">
        <button
          type="button"
          class="btn btn-secondary"
          @click="goBack"
          :disabled="loading"
        >
          <i class="fas fa-arrow-left"></i> Cancelar
        </button>
        
        <button
          type="submit"
          class="btn btn-primary"
          :disabled="loading"
        >
          <span v-if="loading" class="spinner-border spinner-border-sm me-2" role="status"></span>
          <i v-else class="fas fa-save me-2"></i>
          {{ isEditing ? 'Atualizar' : 'Salvar' }}
        </button>
      </div>
    </form>

    <!-- Mensagens de erro gerais -->
    <div v-if="generalError" class="alert alert-danger mt-3">
      {{ generalError }}
    </div>

    <!-- Mensagens de sucesso -->
    <div v-if="successMessage" class="alert alert-success mt-3">
      {{ successMessage }}
    </div>
  </div>
</template>

<script>
export default {
  name: 'UserFormComponent',
  props: {
    actionUrl: {
      type: String,
      required: true
    },
    redirectUrl: {
      type: String,
      required: true
    },
    method: {
      type: String,
      default: 'POST'
    },
    userData: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    return {
      loading: false,
      errors: {},
      generalError: '',
      successMessage: '',
      form: {
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      }
    }
  },
  computed: {
    isEditing() {
      return this.method === 'PUT'
    }
  },
  mounted() {
    // Preencher formulário se estiver editando
    if (this.isEditing && this.userData) {
      this.form.name = this.userData.name || ''
      this.form.email = this.userData.email || ''
    }
  },
  methods: {
    async submitForm() {
      this.loading = true
      this.errors = {}
      this.generalError = ''
      this.successMessage = ''

      try {
        const formData = { ...this.form }
        
        // Remove campos de senha vazios quando editando
        if (this.isEditing && !formData.password) {
          delete formData.password
          delete formData.password_confirmation
        }

        const response = await fetch(this.actionUrl, {
          method: this.method === 'PUT' ? 'POST' : this.method,
          headers: {
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            ...formData,
            ...(this.method === 'PUT' && { _method: 'PUT' })
          })
        })

        const result = await response.json()

        if (response.ok && result.success) {
          this.successMessage = result.message
          
          // Redirecionar após 1.5 segundos
          setTimeout(() => {
            window.location.href = this.redirectUrl
          }, 1500)
        } else {
          if (result.errors) {
            this.errors = result.errors
          } else {
            this.generalError = result.message || 'Erro ao salvar usuário'
          }
        }
      } catch (error) {
        console.error('Erro ao enviar formulário:', error)
        this.generalError = 'Erro de conexão. Tente novamente.'
      } finally {
        this.loading = false
      }
    },

    goBack() {
      if (confirm('Deseja cancelar? As alterações não salvas serão perdidas.')) {
        window.location.href = this.redirectUrl
      }
    },

    clearError(field) {
      if (this.errors[field]) {
        delete this.errors[field]
      }
    }
  },
  watch: {
    'form.name'() {
      this.clearError('name')
    },
    'form.email'() {
      this.clearError('email')
    },
    'form.password'() {
      this.clearError('password')
    },
    'form.password_confirmation'() {
      this.clearError('password_confirmation')
    }
  }
}
</script>

<style scoped>
.user-form {
  max-width: 600px;
  margin: 0 auto;
}

.form-label {
  font-weight: 600;
}

.spinner-border-sm {
  width: 1rem;
  height: 1rem;
}

.alert {
  border-radius: 0.375rem;
}

.btn {
  border-radius: 0.375rem;
}

.form-control:focus {
  border-color: #86b7fe;
  box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
}

.is-invalid {
  border-color: #dc3545;
}

.invalid-feedback {
  display: block;
}
</style> 
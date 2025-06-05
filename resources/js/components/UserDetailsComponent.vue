<template>
  <div class="user-details">
    <!-- Informações do Usuário -->
    <div class="row">
      <div class="col-md-8">
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">
              <i class="fas fa-user me-2"></i>
              Informações do Usuário
            </h5>
          </div>
          <div class="card-body">
            <div class="row">
              <div class="col-md-6 mb-3">
                <strong>ID:</strong>
                <p class="mb-0">{{ userData.id }}</p>
              </div>
              <div class="col-md-6 mb-3">
                <strong>Nome:</strong>
                <p class="mb-0">{{ userData.name }}</p>
              </div>
              <div class="col-md-6 mb-3">
                <strong>Email:</strong>
                <p class="mb-0">{{ userData.email }}</p>
              </div>
              <div class="col-md-6 mb-3">
                <strong>Email Verificado:</strong>
                <span v-if="userData.email_verified_at" class="badge bg-success">
                  <i class="fas fa-check me-1"></i>
                  Verificado
                </span>
                <span v-else class="badge bg-warning">
                  <i class="fas fa-exclamation-triangle me-1"></i>
                  Não Verificado
                </span>
              </div>
              <div class="col-md-6 mb-3">
                <strong>Data de Criação:</strong>
                <p class="mb-0">{{ formatDate(userData.created_at) }}</p>
              </div>
              <div class="col-md-6 mb-3">
                <strong>Última Atualização:</strong>
                <p class="mb-0">{{ formatDate(userData.updated_at) }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Ações -->
      <div class="col-md-4">
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">
              <i class="fas fa-cogs me-2"></i>
              Ações
            </h5>
          </div>
          <div class="card-body">
            <div class="d-grid gap-2">
              <a :href="editUrl" class="btn btn-warning">
                <i class="fas fa-edit me-2"></i>
                Editar Usuário
              </a>
              
              <button 
                @click="confirmDelete"
                class="btn btn-danger"
                :disabled="loading"
              >
                <span v-if="loading" class="spinner-border spinner-border-sm me-2" role="status"></span>
                <i v-else class="fas fa-trash me-2"></i>
                Excluir Usuário
              </button>
              
              <hr>
              
              <a :href="indexUrl" class="btn btn-secondary">
                <i class="fas fa-list me-2"></i>
                Lista de Usuários
              </a>
            </div>
          </div>
        </div>

        <!-- Estatísticas -->
        <div class="card mt-3">
          <div class="card-header">
            <h5 class="mb-0">
              <i class="fas fa-chart-bar me-2"></i>
              Estatísticas
            </h5>
          </div>
          <div class="card-body">
            <div class="row text-center">
              <div class="col-12 mb-2">
                <div class="border rounded p-2">
                  <h6 class="mb-1">Dias Cadastrado</h6>
                  <span class="badge bg-primary">{{ daysSinceCreation }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Timeline de Atividades (exemplo) -->
    <div class="row mt-4">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">
              <i class="fas fa-history me-2"></i>
              Histórico de Atividades
            </h5>
          </div>
          <div class="card-body">
            <div class="timeline">
              <div class="timeline-item">
                <div class="timeline-marker bg-success"></div>
                <div class="timeline-content">
                  <h6 class="timeline-title">Usuário Criado</h6>
                  <p class="timeline-description">
                    Conta criada no sistema
                  </p>
                  <small class="text-muted">{{ formatDate(userData.created_at) }}</small>
                </div>
              </div>
              
              <div v-if="userData.updated_at !== userData.created_at" class="timeline-item">
                <div class="timeline-marker bg-info"></div>
                <div class="timeline-content">
                  <h6 class="timeline-title">Última Atualização</h6>
                  <p class="timeline-description">
                    Dados do usuário foram atualizados
                  </p>
                  <small class="text-muted">{{ formatDate(userData.updated_at) }}</small>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal de Confirmação -->
    <div v-if="showDeleteModal" class="modal fade show d-block" tabindex="-1" style="background-color: rgba(0,0,0,0.5);">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Confirmar Exclusão</h5>
            <button type="button" class="btn-close" @click="cancelDelete"></button>
          </div>
          <div class="modal-body">
            <p>Tem certeza que deseja excluir o usuário <strong>{{ userData.name }}</strong>?</p>
            <p class="text-danger">
              <i class="fas fa-exclamation-triangle me-2"></i>
              Esta ação não pode ser desfeita.
            </p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" @click="cancelDelete">
              Cancelar
            </button>
            <button type="button" class="btn btn-danger" @click="deleteUser" :disabled="loading">
              <span v-if="loading" class="spinner-border spinner-border-sm me-2" role="status"></span>
              Confirmar Exclusão
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'UserDetailsComponent',
  props: {
    userData: {
      type: Object,
      required: true
    },
    editUrl: {
      type: String,
      required: true
    },
    deleteUrl: {
      type: String,
      required: true
    },
    indexUrl: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      loading: false,
      showDeleteModal: false
    }
  },
  computed: {
    daysSinceCreation() {
      const createdAt = new Date(this.userData.created_at)
      const now = new Date()
      const diffTime = Math.abs(now - createdAt)
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
      return diffDays
    }
  },
  methods: {
    formatDate(dateString) {
      const date = new Date(dateString)
      return date.toLocaleDateString('pt-BR', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      })
    },

    confirmDelete() {
      this.showDeleteModal = true
    },

    cancelDelete() {
      this.showDeleteModal = false
    },

    async deleteUser() {
      this.loading = true

      try {
        const response = await fetch(this.deleteUrl, {
          method: 'DELETE',
          headers: {
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          }
        })

        const result = await response.json()

        if (result.success) {
          alert(result.message)
          window.location.href = this.indexUrl
        } else {
          alert('Erro ao excluir usuário')
        }
      } catch (error) {
        console.error('Erro ao excluir usuário:', error)
        alert('Erro de conexão. Tente novamente.')
      } finally {
        this.loading = false
        this.showDeleteModal = false
      }
    }
  }
}
</script>

<style scoped>
.user-details {
  width: 100%;
}

.card {
  border-radius: 0.5rem;
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}

.badge {
  font-size: 0.875rem;
}

.timeline {
  position: relative;
  padding-left: 30px;
}

.timeline-item {
  position: relative;
  margin-bottom: 20px;
}

.timeline-item:before {
  content: '';
  position: absolute;
  left: -20px;
  top: 0;
  bottom: -20px;
  width: 2px;
  background-color: #dee2e6;
}

.timeline-item:last-child:before {
  display: none;
}

.timeline-marker {
  position: absolute;
  left: -25px;
  top: 5px;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  border: 2px solid #fff;
  box-shadow: 0 0 0 2px #dee2e6;
}

.timeline-content {
  background-color: #f8f9fa;
  padding: 15px;
  border-radius: 0.375rem;
  border: 1px solid #dee2e6;
}

.timeline-title {
  margin-bottom: 5px;
  color: #495057;
}

.timeline-description {
  margin-bottom: 5px;
  color: #6c757d;
}

.modal.show {
  display: block;
}

.btn {
  border-radius: 0.375rem;
}

.spinner-border-sm {
  width: 1rem;
  height: 1rem;
}
</style> 
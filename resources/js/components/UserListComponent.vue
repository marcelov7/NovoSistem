<template>
  <div class="users-list">
    <!-- Filtros e Busca -->
    <div class="row mb-3">
      <div class="col-md-6">
        <div class="input-group">
          <input
            v-model="searchTerm"
            type="text"
            class="form-control"
            placeholder="Buscar usuários..."
            @input="debounceSearch"
          />
          <button class="btn btn-outline-secondary" type="button" @click="search">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </div>
      <div class="col-md-6 text-end">
        <select v-model="perPage" @change="search" class="form-select" style="width: auto; display: inline-block;">
          <option value="5">5 por página</option>
          <option value="10">10 por página</option>
          <option value="15">15 por página</option>
          <option value="25">25 por página</option>
        </select>
      </div>
    </div>

    <!-- Loading -->
    <div v-if="loading" class="text-center py-4">
      <div class="spinner-border" role="status">
        <span class="visually-hidden">Carregando...</span>
      </div>
    </div>

    <!-- Tabela de Usuários -->
    <div v-else class="table-responsive">
      <table class="table table-striped table-hover">
        <thead class="table-dark">
          <tr>
            <th @click="sort('id')" style="cursor: pointer;">
              ID
              <i v-if="sortBy === 'id'" :class="sortOrderIcon"></i>
            </th>
            <th @click="sort('name')" style="cursor: pointer;">
              Nome
              <i v-if="sortBy === 'name'" :class="sortOrderIcon"></i>
            </th>
            <th @click="sort('email')" style="cursor: pointer;">
              Email
              <i v-if="sortBy === 'email'" :class="sortOrderIcon"></i>
            </th>
            <th @click="sort('created_at')" style="cursor: pointer;">
              Criado em
              <i v-if="sortBy === 'created_at'" :class="sortOrderIcon"></i>
            </th>
            <th>Ações</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in users.data" :key="user.id">
            <td>{{ user.id }}</td>
            <td>{{ user.name }}</td>
            <td>{{ user.email }}</td>
            <td>{{ formatDate(user.created_at) }}</td>
            <td>
              <div class="btn-group" role="group">
                <a :href="`/users/${user.id}`" class="btn btn-sm btn-info">
                  <i class="fas fa-eye"></i>
                </a>
                <a :href="`/users/${user.id}/edit`" class="btn btn-sm btn-warning">
                  <i class="fas fa-edit"></i>
                </a>
                <button @click="deleteUser(user)" class="btn btn-sm btn-danger">
                  <i class="fas fa-trash"></i>
                </button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Mensagem quando não há usuários -->
      <div v-if="users.data.length === 0" class="text-center py-4">
        <p class="text-muted">Nenhum usuário encontrado.</p>
      </div>
    </div>

    <!-- Paginação -->
    <nav v-if="users.data.length > 0" aria-label="Navegação da página">
      <ul class="pagination justify-content-center">
        <li class="page-item" :class="{ disabled: users.current_page === 1 }">
          <a class="page-link" href="#" @click.prevent="changePage(users.current_page - 1)">
            Anterior
          </a>
        </li>
        
        <li
          v-for="page in visiblePages"
          :key="page"
          class="page-item"
          :class="{ active: page === users.current_page }"
        >
          <a class="page-link" href="#" @click.prevent="changePage(page)">
            {{ page }}
          </a>
        </li>
        
        <li class="page-item" :class="{ disabled: users.current_page === users.last_page }">
          <a class="page-link" href="#" @click.prevent="changePage(users.current_page + 1)">
            Próximo
          </a>
        </li>
      </ul>
    </nav>

    <!-- Informações de paginação -->
    <div v-if="users.data.length > 0" class="text-center text-muted mt-2">
      Mostrando {{ users.from }} até {{ users.to }} de {{ users.total }} usuários
    </div>
  </div>
</template>

<script>
export default {
  name: 'UserListComponent',
  props: {
    usersData: {
      type: Object,
      required: true
    },
    usersUrl: {
      type: String,
      required: true
    },
    createUrl: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      users: this.usersData,
      loading: false,
      searchTerm: '',
      searchTimeout: null,
      perPage: 15,
      sortBy: 'created_at',
      sortOrder: 'desc'
    }
  },
  computed: {
    sortOrderIcon() {
      return this.sortOrder === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'
    },
    visiblePages() {
      const pages = []
      const current = this.users.current_page
      const total = this.users.last_page
      
      for (let i = Math.max(1, current - 2); i <= Math.min(total, current + 2); i++) {
        pages.push(i)
      }
      
      return pages
    }
  },
  methods: {
    debounceSearch() {
      clearTimeout(this.searchTimeout)
      this.searchTimeout = setTimeout(() => {
        this.search()
      }, 500)
    },
    
    async search() {
      this.loading = true
      
      try {
        const params = new URLSearchParams({
          search: this.searchTerm,
          per_page: this.perPage,
          sort_by: this.sortBy,
          sort_order: this.sortOrder,
          page: 1
        })
        
        const response = await fetch(`${this.usersUrl}?${params}`)
        this.users = await response.json()
      } catch (error) {
        console.error('Erro ao buscar usuários:', error)
      } finally {
        this.loading = false
      }
    },
    
    async changePage(page) {
      if (page < 1 || page > this.users.last_page) return
      
      this.loading = true
      
      try {
        const params = new URLSearchParams({
          search: this.searchTerm,
          per_page: this.perPage,
          sort_by: this.sortBy,
          sort_order: this.sortOrder,
          page: page
        })
        
        const response = await fetch(`${this.usersUrl}?${params}`)
        this.users = await response.json()
      } catch (error) {
        console.error('Erro ao carregar página:', error)
      } finally {
        this.loading = false
      }
    },
    
    sort(field) {
      if (this.sortBy === field) {
        this.sortOrder = this.sortOrder === 'asc' ? 'desc' : 'asc'
      } else {
        this.sortBy = field
        this.sortOrder = 'asc'
      }
      this.search()
    },
    
    async deleteUser(user) {
      if (!confirm(`Tem certeza que deseja excluir o usuário ${user.name}?`)) {
        return
      }
      
      try {
        const response = await fetch(`/users/${user.id}`, {
          method: 'DELETE',
          headers: {
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          }
        })
        
        const result = await response.json()
        
        if (result.success) {
          this.search() // Recarrega a lista
          alert(result.message)
        } else {
          alert('Erro ao excluir usuário')
        }
      } catch (error) {
        console.error('Erro ao excluir usuário:', error)
        alert('Erro ao excluir usuário')
      }
    },
    
    formatDate(dateString) {
      const date = new Date(dateString)
      return date.toLocaleDateString('pt-BR') + ' ' + date.toLocaleTimeString('pt-BR')
    }
  }
}
</script>

<style scoped>
.users-list {
  width: 100%;
}

.table th[style*="cursor: pointer"]:hover {
  background-color: #495057;
}

.btn-group .btn {
  margin-right: 2px;
}

.btn-group .btn:last-child {
  margin-right: 0;
}
</style> 
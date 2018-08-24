Rails.application.routes.draw do
  get 'relatorio_diario/index'

  get 'situacao_alunos/index'

  get 'home/index'

  root 'home#index'

  get 'home/sobre'

  resources :folha_semanals
  resources :usuario_turmas
  resources :turmas
  resources :usuarios
  resources :perfils

  get 'situacao_alunos/desmatricular(/:id)', to: 'situacao_alunos#desmatricular'
  get 'situacao_alunos/matricular(/:id)', to: 'situacao_alunos#matricular'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'relatorio_diario/index'

  get 'situacao_alunos/index'

  get 'home/index'

  root 'home#index'

  resources :folha_semanals
  resources :usuario_turmas
  resources :turmas
  resources :usuarios
  resources :perfils
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

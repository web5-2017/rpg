Rails.application.routes.draw do
  ################################ Rotas para devise ###############################
  devise_for :users

  ################################ Rota index ###############################
  root 'home#index'

  ################################ Rotas para o usuário###############################
  get '/profile', to: 'profile#index'
  get '/profile/edit', to: 'profile#edit'
  
  resources :users, only: :update

  ################################ Rotas para upload de images ###############################
  resources :pictures, only: [:index, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

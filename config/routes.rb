Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  ################################ Rotas para devise ###############################
  devise_for :users

  ################################ Rota index ###############################
  root 'home#index'

  ################################ Rotas para historias ###############################
  resources :histories, only: [:show, :index]

  ################################ Rotas para o usuário###############################
  get '/profile', to: 'profile#index'
  get '/profile/edit', to: 'profile#edit'

  resources :users, only: :update

  ################################ Rotas para upload de images ###############################
  resources :pictures, only: [:index, :create]

  ################################ Rotas para partidas ###############################
  namespace :match do
    resources :games, only: [:index, :show, :new, :create] do
      resources :histories, only: [:index] do
        get '/add_history', to: 'games#add_history'
        delete '/remove_history', to: 'games#remove_history'
      end
    end
    ################################ Rotas para historias ###############################

    resources :histories, only: [:new, :create, :show]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

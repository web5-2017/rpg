Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  ################################ Rotas para devise ###############################
  devise_for :users

  ################################ Rota index ###############################
  root 'home#index'

  ################################ Rotas para historias ###############################
  resources :histories, only: [:show, :index]

  ################################ Rotas para upload de images ###############################
  resources :pictures, only: [:index, :create]

  ################################ Rotas para profile ###############################
  namespace :profile do
    ################################ Rotas para o usuário###############################
    root 'dashboard#index'
    get '/edit', to: 'dashboard#edit'
    get '/search_users', to: 'dashboard#search_users'

    resources :users, only: :update do
      get '/adding_friend', to: 'users#adding_friend'
      get '/removing_friend', to: 'users#removing_friend'
    end

    ################################ Rotas para o games ###############################
    get 'games_that_i_play', to: 'games#games_that_i_play'
    resources :games do

      ################################ Rotas para o histories em games ###############################
      resources :histories, only: :index do
        get '/add_history', to: 'games#add_history'
        delete '/remove_history', to: 'games#remove_history'

        ################################ Rotas para o challenges ###############################
        resources :challenges do
          delete '/alternatives/:id', to: 'alternatives#destroy', as: 'alternative'
        end
      end

      ################################ Rotas para Items ###############################
      resources :items

      ################################ Rotas para Raças ###############################
      resources :breeds

      ################################ Rotas para Personagens ###############################
      resources :characters

      resources :players, only: :index

      get '/friend_list', to: 'players#friend_list'
      get '/players/:id/add', to: 'players#adding_friend', as: 'add_friend'
      get '/players/:id/remove', to: 'players#removing_friend', as: 'remove_friend'
    end# >>>>>>>>>>>>>>> Fim Rotas Games

    ################################ Rotas para historias ###############################
    get '/my-histories', to: 'histories#my_histories'
    resources :histories, except: :index do

      ################################ Rotas para Mapas ###############################
      resources :maps
    end
  end# >>>>>>>>>>>>>>> Fim Rotas profile

  ################################ Rotas para Match ###############################
  namespace :match do
    resources :game, only: :show
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  get '/cast_dice', to: 'dices#cast_dice'
  get '/game/:game_id/breeds/:id', to: 'breeds#show', as: :bread_characters

  ################################ Rotas para devise ###############################
  devise_for :users

  ################################ Rota index ###############################
  root 'home#index'

  ################################ Rotas para historias ###############################
  resources :histories, only: [:show, :index]

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
      end
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
    resources :histories, except: :index
  end# >>>>>>>>>>>>>>> Fim Rotas profile

  ################################ Rotas para Match ###############################
  namespace :match do
    scope '/game/:game_id' do
      root 'dashboard#index'

      get '/character', to: 'characters#show'
      patch '/character', to: 'characters#update'
      post '/character', to: 'characters#create'
      post '/save_attrs', to: 'characters#save_attrs'
      get '/character/edit', to: 'characters#edit'
      get '/character/new', to: 'characters#new'

      get '/sessions/:id/run_code', to: 'sessions#run_code', as: 'sessions_run_code'
    end
  end

  ################################ Rotas para GM Match (área do gm) ###############################
  namespace :gm_match do
    scope '/game/:game_id' do
      root 'dashboard#index'

      resources :characters, path: 'characters/:type'

      resources :sessions, only: :create
      get '/sessions/:id/run_code', to: 'sessions#run_code', as: 'sessions_run_code'
    end
  end# >>>>>>>>>>>>>>> Fim Rotas gm match

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

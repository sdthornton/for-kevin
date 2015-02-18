Rails.application.routes.draw do
  root 'home#index'

  get 'about' => 'home#about'
  get 'my_bids' => 'home#user_bids', as: 'show_my_bids'

  scope 'users' do
    delete ':id' => 'home#delete_user', as: 'delete_user'
  end

  devise_for :admins, path: 'admin', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  devise_for :users, path: 'user', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  devise_scope :user do
    get '/login' => 'devise/sessions#new', as: 'login'
    get '/logout' => 'devise/sessions#destroy', as: 'logout'
    get '/register' => 'devise/registrations#new', as: 'register'
  end

  resources :haircuts, except: [:show, :edit] do
    resources :bids, except: [:edit, :update, :index, :show]
  end

  scope 'haircuts' do
    get ':url' => 'haircuts#show', as: 'show_haircut'
    get ':url/edit' => 'haircuts#edit', as: 'edit_haircut'
    get 'filter/:letter' => 'haircuts#index', as: 'filter_haircuts'
    get 'page/:page' => 'haircuts#index'
  end

  resources :system_config, only: [:update]
  get '/admin/config' => 'system_config#edit', as: 'edit_system_config'

  get '/admin/bids' => 'home#bids', as: 'show_bids'
  get '/admin/users' => 'home#users', as: 'show_users'
end

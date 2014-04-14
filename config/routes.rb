CutTheChi::Application.routes.draw do
  root 'home#index'

  get 'about' => 'home#about'
  get 'bids' => 'home#bids', as: 'show_bids'
  get 'users' => 'home#users', as: 'show_users'
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

  # scope 'admin' do
  #   get 'haircuts' => 'haircuts#index'
  # end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

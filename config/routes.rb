Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :registrations => 'dashboard/registrations' } 
  filter :locale

  root 'main#index'

  devise_scope :user do
    post   '/users/sign_in'  => 'devise/sessions#create',  as: :login
    delete '/users/sign_out' => 'devise/sessions#destroy', as: :logout
    delete '/users' => 'devise/registrations#destroy'

    # post  '/users/password'  => 'devise/passwords#create', as: :user_password
    # put   '/users/password'  => 'devise/passwords#update', as: nil
    # patch '/users/password'  => 'devise/passwords#update', as: nil
  end

  scope module: 'home' do
    #resources :user_sessions, only: [:new, :create]
    resources :users, only: [:new, :create]
    #get 'login' => 'user_sessions#new', :as => :login
    #get 'login' => 'devise/sessions#create', :as => :login
    #post '/users/sign_in'  => 'devise/sessions#create',  as: :user_session
    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  end

  scope module: 'dashboard' do
    #resources :user_sessions, only: :destroy
    #resources :users, only: :destroy

    resources :cards

    resources :blocks do
      member do
        put 'set_as_current'
        put 'reset_as_current'
      end
    end
    
    put 'review_card' => 'trainer#review_card'
    get 'trainer' => 'trainer#index'

    get 'profile/:id/edit' => 'profile#edit', as: :edit_profile
    put 'profile/:id' => 'profile#update', as: :profile
  end
end

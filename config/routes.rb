Rails.application.routes.draw do
  # devise_for :users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)

  mount ApiPromptcards::Engine, at: "/api_promptcards"

  devise_for :admin_users, {class_name: 'User'}.merge(ActiveAdmin::Devise.config)
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { registrations: "my_devise/registrations" }

  filter :locale

  root 'main#index'

  resources :users

  devise_scope :user do
    get "sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "sign_up" => "devise/registrations#new" #, as: "new_user_registration" # custom path to sign_up/registration
  end

  scope module: 'home' do
    resources :user_sessions, only: [:new, :create]
    resources :users, only: [:new, :create]

    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  end

  scope module: 'dashboard' do
    resources :user_sessions, only: :destroy
    resources :users, only: :destroy
    
    resources :cards
    resources :flickrs, only: [:index, :search]
    
    get 'flickrs/search' => 'flickrs#search'
    
    resources :blocks do
      member do
        put 'set_as_current'
        put 'reset_as_current'
      end
    end

    #put 'review_card' => 'trainer#review_card'
    #get 'trainer' => 'trainer#index'

    get 'profile/:id/edit' => 'profile#edit', as: :edit_profile
    put 'profile/:id' => 'profile#update', as: :profile
  end
end

Rails.application.routes.draw do
  devise_for :users
  get 'users/sign_up'
  get 'users/login'
  get 'sign_up/login'
  resources :flower_types, only: [:index, :show]
  resources :flower_colours, only: [:index, :show]
  resources :products, only: [:index, :show]
  resources :cart, only: [:create, :destroy, :index]

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "products#index"
end

Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :orders, only: [:index, :create]
  end

  get "/debug_users", to: "application#debug_users"
  
end

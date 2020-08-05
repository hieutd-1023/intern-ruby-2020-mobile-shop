Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/help", to: "static_pages#help"
    resources :products
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    namespace :admins do
      root to: "products#index"
      resources :products
    end
  end
end

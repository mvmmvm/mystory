Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'rooms/:id/chats', to: "rooms#chats"
  resources :stories

  resources :rooms do
    resources :characters
    resources :players
  end
end

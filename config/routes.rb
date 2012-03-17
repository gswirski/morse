Morse::Application.routes.draw do
  resources :pastes
  resources :users
  resource :session, only: [:new, :create, :destroy]

  root to: "pastes#new"
end

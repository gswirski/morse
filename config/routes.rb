Morse::Application.routes.draw do
  resources :pastes

  resource :user
  resource :session, only: [:new, :create, :destroy]

  root to: "pastes#new"
end

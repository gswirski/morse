Morse::Application.routes.draw do
  resources :pastes

  resource :user do
    member do
      post "reset_token", to: "users#reset_token"
    end
  end
  resource :session, only: [:new, :create, :destroy]

  root to: "pastes#new"
end

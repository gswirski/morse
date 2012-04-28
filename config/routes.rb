Morse::Application.routes.draw do
  resources :pastes do
    get "download", on: :member
  end

  resource :user do
    post "reset_token", on: :member
  end
  resource :session, only: [:new, :create, :destroy]

  root to: "pastes#new"
end

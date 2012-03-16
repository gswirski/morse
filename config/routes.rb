Morse::Application.routes.draw do
  resources :pastes
  resources :users

  root :to => "pastes#new"
end

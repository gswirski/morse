Morse::Application.routes.draw do
  resources :pastes do
    get "download", :on => :member
  end

  resources :users

  root :to => "pastes#new"
end

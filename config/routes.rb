Morse::Application.routes.draw do
  resources :pastes do
    get "download", :on => :member
  end
  root :to => "pastes#new"
end

Tuam::Application.routes.draw do
  root :to => "welcome#index"
  resources :clients
end

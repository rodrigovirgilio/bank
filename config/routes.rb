Rails.application.routes.draw do
  resources :customers, except: %w[destroy]
end

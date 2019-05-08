Rails.application.routes.draw do
  resources :customers, except: %w[destroy]
  resources :account_transactions, only: %w[index create new]
end

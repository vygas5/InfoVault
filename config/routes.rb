Rails.application.routes.draw do
  resource :session
  resource :registration, only: %i[ new create ]

  resources :vault_entries

  get "up" => "rails/health#show", as: :rails_health_check

  root "vault_entries#index"
end

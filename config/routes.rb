Rails.application.routes.draw do
  root to: "results#index"
  resources :users do
    resources :results, only: [:index, :new, :create]
  end
  resources :results, only: [:index, :create, :show]
end

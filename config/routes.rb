Rails.application.routes.draw do
  root to: "results#index"
  resources :users do
    resources :results, only: [:index, :new, :create,:show]
  end
  resources :results, only: [:index, :create, :show]

  get 'life_pass_numbers', to: 'life_pass_numbers#show'
end


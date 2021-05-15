Rails.application.routes.draw do
  devise_for :users
  root to: 'messages#index'
  resources :messages do
    resources :orders, only: [:index, :create]
  end
end

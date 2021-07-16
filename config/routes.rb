Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:index, :new, :create, :show, :edit, :destroy]
end

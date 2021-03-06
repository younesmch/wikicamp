Rails.application.routes.draw do

  post '/downgrade' => 'users#downgrade', as: :downgrade

  resources :wikis

  resources :charges, only: [:new, :create]

  resources :collaborators, only: [:create, :destroy]

  devise_for :users

  get 'about' => 'welcome#about'

  root 'welcome#index'

end

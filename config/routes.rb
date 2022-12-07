Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :csv_files, only: [:new, :create]
end

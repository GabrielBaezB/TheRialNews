Rails.application.routes.draw do
  resources :news do
    resources :comments, only: [:create, :destroy, :show]
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
   }
  get 'home/index'
  root "home#index"
end

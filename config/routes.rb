Rails.application.routes.draw do
  devise_for :users,
  	controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'profiles#home'
  resources :profiles, only: [ :create, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :jobs, only:[:index, :show]
  resources :users, only: [ :show]
 
end

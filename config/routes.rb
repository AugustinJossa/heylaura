Rails.application.routes.draw do
  devise_for :users
  root to: 'profiles#home'
  get 'test', to: 'profiles#test'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

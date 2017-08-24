Rails.application.routes.draw do
  devise_for :users,
  	controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'profiles#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :profiles, only:[:show] do

  resources :matched_jobs, only:[:index, :show] do
    collection do
        post 'filter', to: "profiles#filter"
      end
    end
  end


end

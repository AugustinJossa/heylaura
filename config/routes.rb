Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users,
  	controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'profiles#home'
  resources :profiles, only: [ :create, :show] do
    collection do
      get :test # for testing only
    end
    member do
      get :find_match
      # get :test # for testing only
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :profiles, only:[:show, :edit, :update] do


  resources :matched_jobs, only:[:index, :show, :update] do

    collection do
        post 'filter', to: "profiles#filter"
      end
    end
  end

  resources :jobs, only:[:index, :show]

  
  resources :users, only: [ :show] do
    member do                      
      get 'accepted', to: "users#accepted" #Users controller
    end
  end

  resources :matched_jobs do
    member do
      get 'preparation', to: "matched_jobs#preparation" #MatchedJob controller
    end
  end

  resources :users, only: [ :show] do
    member do
      get :manage_connection
    end
  end

end



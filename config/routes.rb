Rails.application.routes.draw do
  devise_for :users,
  	controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'profiles#home'
  resources :profiles, only: [ :create, :show] do
    member do
      get :find_match
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :profiles, only:[:show] do

  resources :matched_jobs, only:[:index, :show] do
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

end



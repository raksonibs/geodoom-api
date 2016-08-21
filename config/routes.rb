Rails.application.routes.draw do  
  use_doorkeeper
  root to: "application#index"

  namespace :api do
    namespace :v1 do
      root to: "base#index"
      get '/users/me', to: 'users#me'
      resources :users
      resources :balance_changes
      resources :pet_states, except: [:new, :edit]
      resources :states, except: [:new, :edit]
      resources :stats, except: [:new, :edit]
      resources :pets, except: [:new, :edit]
      resources :battles, except: [:new, :edit]
      resources :sessions do 
         post 'auth/steam/callback' => 'sessions#auth_callback'
      end
    end
  end
end

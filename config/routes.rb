Rails.application.routes.draw do  
  use_doorkeeper
  root to: "application#index"  
  post 'auth/steam/callback' => 'api/v1/sessions#auth_callback'
      
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
    end
  end
end

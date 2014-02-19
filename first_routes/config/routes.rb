FirstRoutes::Application.routes.draw do
  resources :users, :only => [:index, :destroy, :create, :update, :show] do
    resources :contacts, :only => :index
    member do
      get 'favorite'
    end
  end
  resources :contacts, :only => [:destroy, :create, :update, :show]
  resources :contact_shares, :only => [:destroy, :create]

end

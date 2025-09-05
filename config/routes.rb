Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  get '/monitor/health', to: 'monitor#health'
  # mount RailsAdminImport::Engine => '/rails_admin_import', :as => 'rails_admin_import'
  resources :file_upload, only: [:new, :create]


  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    cas_sessions: "users/cas_sessions",
  }

  devise_scope :user do
    authenticated :user do
      # Rails 4 users must specify the 'as' option to give it a unique name
      root :to => "home#home", :as => :authenticated_root
    end

    unauthenticated :user do
      root :to => "devise/cas_sessions#new"
    end
  end

  resources :reports, :only => [:index]

  resources :diagrams do
    member do
      get 'download'
    end
  end

  resources :users do
    collection do
      get :export_users_awaiting_approval
      get :export_all
    end
  end

  resources :institutions

  resources :user_logs, only: [] do
    collection do
      get :export
    end
  end

  get 'home' => 'home#home'
  get 'home/news'
end

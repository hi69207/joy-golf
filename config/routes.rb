Rails.application.routes.draw do

  devise_for :admin, path: 'admin', skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    get "customers/my_page" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    patch "customers/withdraw" => "customers#withdraw"
    resources :courses, only: [:index, :show] do
      resources :posts, only: [:index, :create, :show, :edit, :update, :destroy]
    end
  end

  namespace :admin do
    root to: "homes#top"
    get "top" => "homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :courses, only: [:index, :show, :create, :edit, :update] do
      resources :posts, only: [:show, :edit, :update, :destroy]
    end
    resources :prefectures, only: [:index, :create, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

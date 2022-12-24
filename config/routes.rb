Rails.application.routes.draw do

  root to: "homes#top"
  get "/about" => "homes#about", as: "about"
  get "search" => "searches#search"

  # 顧客側
  scope module: :public do
    resources :ships, except: [:new, :show]
    resources :orders,only: [:new, :create, :index, :show] do
      collection do
        post "confirm"
        get "complete"
      end
    end

    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "destroy_all"
      end
    end

    resource :customers, only: [:show, :edit, :update] do
      get "unsubscribe"
      patch "withdraw"
    end

    resources :items, only: [:index, :show] do
    end
  end

  # 管理者側
  namespace :admin do
    get "/" => "homes#top"
    resources :items, except: [:destroy]
    resources :genres, except: [:show, :destroy, :new]
    resources :customers, except: [:new, :create, :destroy]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]

  end

  # 管理者認証用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 顧客認証用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end


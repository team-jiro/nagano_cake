Rails.application.routes.draw do

# 顧客側
  namespace :public do

    root to: "homes#top"
    get "/about" => "homes#about", as: "about"

    resources :ships, except: [:new, :show]
    end

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

  # 管理者側
  namespace :admin do
    resources :items, except: [:destroy]
    resources :genres, except: [:show, :destroy, :new]
    resources :customers, except: [:new, :create, :destroy]
    resources :orders, only: [:index, :show, :update]
  end

 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

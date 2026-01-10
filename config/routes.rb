Rails.application.routes.draw do
  root "top#index"
  #未ログイン状態での商品検索
  resources :items,  only: [:index, :show] do
    get "search" , on: :collection
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :new , :create , :edit ,:update] do
    resources :orders
  end
  resource :password, only: [:show, :edit, :update]
  resource :cart, only: [:show] do
    post :add
    post :zero
    post :confirm
  end

  get "login" => "top#login"


  
  #店員のルーティング roleが2のとき
  namespace :staff do
    root "top#index"
    resources :orders, only: [:index, :show ,:edit, :update] do
    end
    resources :stocks, only: [:index, :update]
  end
  
  #管理者のルーティング roleが3のとき
  namespace :admin do
    root "top#index"
    resources :members
    resources :stocks 
    resources :orders do
      get "sales" ,on: :collection

    end
    resources :items do
      get "sales" ,on: :collection
    end
  end
end

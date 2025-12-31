Rails.application.routes.draw do
  root "top#index"
  #未ログイン状態での商品検索
  resources :items,  only: [:index, :show] do
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update] do
    resource :orders, only: [:index, :show]
  end
  resource :password, only: [:show, :edit, :update]
  resource :cart, only: [:new,:show]

  get "login" => "top#login"

  #注文明細一覧ページ用
  resources :details, only: [:index]
  
  #店員のルーティング
  namespace :staff do
    root "top#index"
    resources :orders, only: [:index, :show ] do
    end
    resources :stocks, only: [:index, :show]
  end
  
  namespace :admin do
    root "top#index"
    resources :members , only: [:edit, :show]
    resources :stocks 
    resources :items do
      get "sales" ,on: :collection
    end
  end
end

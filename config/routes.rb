Rails.application.routes.draw do
  # ログイン・ログアウト
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # 支払い・借金
  resources :payments
  resources :debts do
    collection do
      get 'for_me'  # 自分が返すべき借金
    end
  end

  # ヘルスチェック & ルート
  get "up" => "rails/health#show", as: :rails_health_check
  root "payments#index"
end
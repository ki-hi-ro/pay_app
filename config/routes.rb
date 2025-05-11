Rails.application.routes.draw do
  # ログイン・ログアウト
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # 支払い・返済
  resources :payments do
    member do
      get 'debts/edit', to: 'debts#edit_for_payment', as: :edit_debts
      patch 'debts/update_multiple', to: 'debts#update_multiple', as: :update_debts
    end
  end

  resources :debts do
    collection do
      get 'for_me'
    end
  end

  # ヘルスチェック & ルート
  get "up" => "rails/health#show", as: :rails_health_check
  root "payments#index"
end
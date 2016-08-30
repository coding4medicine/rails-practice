Rails.application.routes.draw do

  resources :buy_plans, only: [:new, :create]
  resources :buy_books, only: [:new, :create]
  resources :sshkeys

  scope module: 'admin' do
     resources :plans, :books, :cards, :referrals, :keys
  end

  get 'pages/page0'
  get 'pages/page1'
  get 'pages/page2'
  get 'pages/products'

  root :to => 'pages#index'

  get 'admin', to: 'admin/pages#index'

  devise_for :admins
  devise_for :users
  
end

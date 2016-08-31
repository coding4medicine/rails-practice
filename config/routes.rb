Rails.application.routes.draw do

  resources :buy_plans, only: [:new, :create, :edit]
  resources :buy_books, only: [:new, :create, :edit]
  resources :sshkeys
  get '/buy_books/new/:id', to: 'buy_books#new'
  get '/buy_books/edit', to: 'buy_books#edit'
  get '/buy_plans/new/:id', to: 'buy_plans#new'
  get '/buy_plans/edit', to: 'buy_plans#edit'

  scope module: 'admin' do
     resources :plans, :books, :cards, :referrals, :keys
  end

  get 'pages/webhook', to: 'pages#webhook'
  post 'pages/webhook', to: 'pages#webhook'
  get 'pages/page0'
  get 'pages/page1'
  get 'pages/page2'
  get 'pages/products'

  root :to => 'pages#index'

  get 'admin', to: 'admin/pages#index'

  devise_for :admins
  devise_for :users
  
end

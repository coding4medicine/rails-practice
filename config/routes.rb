Rails.application.routes.draw do

  resources :sshkeys

  scope module: 'admin' do
     resources :plans, :books, :cards, :referrals, :keys
  end

  get 'pages/page0'
  get 'pages/page1'
  get 'pages/page2'
  get 'pages/book'

  root :to => 'pages#index'

  devise_for :admins
  devise_for :users
  
end

Rails.application.routes.draw do
  resources :book_purchases
  resources :cards
  resources :plan_purchases
  resources :stripe_events
  resources :referrals
  resources :plans
  resources :books
  resources :sshkeys
  devise_for :admins
  get 'pages/page0'

  get 'pages/page1'

  get 'pages/page2'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

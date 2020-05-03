Rails.application.routes.draw do



  get 'order_process/processOrder'
  get 'purchase_history/byUser'
  get 'purchase_history/byItem'

  get 'payment_gateway/confirm'
  get 'wishes/show'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'welcome/index'
  post 'orders/updated' => 'orders#updated', :as => :orders_update
  post 'return_items/updated' => 'return_items#updated', :as => :return_items_update
  post 'return_items/requested' => 'return_items#requested', :as => :return_items_update_status
  get 'return_items/request' => "return_items#request", as: "return_item_path"
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  post 'cart_items/:id/add' => "cart_items#add_quantity", as: "cart_item_add"
  post 'cart_items/:id/reduce' => "cart_items#reduce_quantity", as: "cart_item_reduce"
  post 'cart_items' => "cart_items#create"
  get 'cart_items/:id' => "cart_items#show", as: "cart_item"
  delete 'cart_items/:id' => "cart_items#destroy"


  get 'wishes/:id' => "wishes#show", as: "wish"
  delete 'wishes/:id' => "wishes#destroy"
  post 'wish_items/:id/add' => "wish_items#add_quantity", as: "wish_item_add"
  post 'wish_items/:id/reduce' => "wish_items#reduce_quantity", as: "wish_item_reduce"
  post 'wish_items' => "wish_items#create"
  get 'wish_items/:id' => "wish_items#show", as: "wish_item"
  delete 'wish_items/:id' => "wish_items#destroy"
  post 'items/subscribe/:id' => "items#addsubscription", as: "subscribe"
  post 'payment_gateway/finish' => "payment_gateway#verifyOTP", as: "verify"
  post :item_subscribe_mailer, to: 'notification#item_subscribe_mailer', as: :item_subscribe_mailer

  post 'user/orders/new' => "orders#new", as: "new_order_path"



  scope :user do

    resources :return_items
    resources :orders
    resources :cart_items
    resources :carts
    resources :users
    resources :payment_details
    resources :feedbacks
    resources :items

  end
  resources :feedbacks, only: [:show, :new, :create]

  root 'welcome#index'



  resources :items


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

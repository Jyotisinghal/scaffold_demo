Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :orders, only: [:new, :create]
    resources :line_items, :carts
    root 'store#index', as: 'store_index', via: :all
  end 
  
  # get 'order/index', as: 'orders'
  # get 'order/new'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

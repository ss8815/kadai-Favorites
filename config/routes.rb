Rails.application.routes.draw do
  root to: 'toppages#index'
    
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
    
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  #Micropostの一覧はユーザに紐付いているのでtoppages#indexやusers#showで表示する
  resources :microposts, only: [:create, :destroy]
end
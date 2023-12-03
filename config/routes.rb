Rails.application.routes.draw do
  root 'pages#index'
  resource :session, only: %i[create destroy new]
  resources :users
  resources :questions do
    resources :answers, only: %i[create destroy update edit]
  end

  namespace :admin do
    resources :users, only: %i[index create]
  end
end

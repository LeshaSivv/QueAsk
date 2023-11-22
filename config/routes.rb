Rails.application.routes.draw do
  root 'pages#index'
  resources :users
  resources :questions do
    resources :answers, only: %i[create destroy update edit]
  end
end

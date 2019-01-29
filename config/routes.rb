Rails.application.routes.draw do
  devise_for :users
  root to: 'platforms#index'

  resources :platforms do
    resources :analytics, only: [:index]
    get  'tree', to: :tree, defaults: { format: 'xml' }

    # Facebook webhook
    get  'webhook', to: :webhook
    post 'webhook', to: 'platforms#receive_message'
  end

  namespace :admin do
  	resources :users
    resources :custom_loggers, only: [:index, :show]
    resources :user_sessions, only: [:index, :destroy]
    resources :off_topics do
      post 'train', on: :collection
    end
  end

  mount ActionCable.server => '/cable'
end

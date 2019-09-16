Rails.application.routes.draw do
  get 'welcome/index'

  resources :articles do
    resources :comments
  end

  resources :feeds do
    resources :items
  end

  root 'welcome#index'
end

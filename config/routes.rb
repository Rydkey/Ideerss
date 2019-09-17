Rails.application.routes.draw do
  get 'welcome/index'

  resources :feeds do
    resources :items, only: [:show, :set_to_read]
  end

  get '/items/:id/set_to_read', to: 'items#set_to_read', as: 'read_button'
  get '/feeds/:id/refresh', to: 'feeds#refresh', as: 'refresh_button'

  root 'feeds#index'
end

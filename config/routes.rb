Rails.application.routes.draw do
  resources :urls, only: [:create]
  get '/:short_url', to: 'urls#show', as: :short
  get '/urls/top', to: 'urls#top' 
end

Rails.application.routes.draw do
  get 'api/v1/artists', to: 'artists#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

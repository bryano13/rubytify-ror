Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'api/v1/artists', to: 'artists#index'
  get 'api/v1/artists/:id/albums', to: 'albums#artist_albums'
  # get '/api/v1/albums/:id/songs' to 'songs#album_songs'
end

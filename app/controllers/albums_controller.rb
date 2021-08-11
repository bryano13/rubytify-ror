class AlbumsController < ApplicationController
  def artist_albums
        artist = Artist.find(params[:id])
        @albums = artist.albums
        render json: @albums, root: 'data', each_serializer: AlbumSerializer, adapter: :json, status: :ok
    end
end

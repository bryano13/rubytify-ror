class SongsController < ApplicationController
    # /api/v1/albums/:id/songs
    def album_songs
        album = Album.find(params[:id])
        @songs = album.songs
        render json: @songs
    end

    def random_songs
        
    end

end

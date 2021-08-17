class SongsController < ApplicationController
    # /api/v1/albums/:id/songs
    def album_songs
        album = Album.find(params[:id])
        @tracks = album.songs
        render json: @tracks, root: 'data', each_serializer: SongSerializer, adapter: :json, status: :ok
    end

    #  /api/v1/genres/:genre_name/random_song
    def random_song
        genre_dict = {chosen_genre: "%\"#{params[:genre_name]}\"%"}
        @genre = Artist.where("cast(genres AS VARCHAR) LIKE :chosen_genre", genre_dict)
        @artist = @genre.sample
        @track = @artist.albums.sample.songs.sample
        render json: @track, root: 'data', adapter: :json, status: :ok
    end
end

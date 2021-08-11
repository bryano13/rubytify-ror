class ArtistsController < ApplicationController
    # /api/v1/artists
    def index
        @artists = Artist.all.order('popularity DESC')
        # puts "This are the artists: #{@artists}"
        render json: @artists, root: 'data', each_serializer: ArtistSerializer, adapter: :json, status: :ok
    end
end

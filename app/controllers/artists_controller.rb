class ArtistsController < ApplicationController
    def index
        @artists = Artist.all.order('popularity DESC')
        render json: @artists, root: 'data', each_serializer: ArtistSerializer, adapter: :json, status: :ok
    end
end

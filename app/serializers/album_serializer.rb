#Class to seriliaze the albums
class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :spotify_url, :total_tracks
end
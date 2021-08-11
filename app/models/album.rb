class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :delete_all

  validates_presence_of :name, :total_tracks, :spotify_url, :spotify_id, :artist_id
end

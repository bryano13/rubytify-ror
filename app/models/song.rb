class Song < ApplicationRecord
  belongs_to :album

  validates_presence_of :name, :duration_ms, :spotify_id, :album_id
end

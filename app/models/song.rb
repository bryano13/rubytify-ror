class Song < ApplicationRecord
  belongs_to :album

  validates_presence_of :name, :duration_ms, :explicit, :spotify_id, :album_id
end

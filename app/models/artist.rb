class Artist < ApplicationRecord
    has_many :albums, dependent: :delete_all
    has_many :songs, through: :albums

    validates_presence_of :name, :image, :genres, :popularity, :spotify_url, :spotify_id
end

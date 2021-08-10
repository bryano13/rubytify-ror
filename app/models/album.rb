class Album < ApplicationRecord
  belongs_to :artist
  has_many :songs, dependent: :delete_all
end

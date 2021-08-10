class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :image
      t.string :genres
      t.integer :popularity
      t.text :spotify_url
      t.string :spotify_id

      t.timestamps
    end
  end
end

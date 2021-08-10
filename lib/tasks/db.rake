require 'yaml'
require 'rspotify'


desc 'Loads seed artists data => fetchs from Spotify API => populates databases'
task read_file: :environment do
    # Helps reset the data on all databases (to avoid duplicates)
    Rake::Task['db:reset'].invoke

    artists_yaml = YAML.load(File.read('artists.yml'))
    artists_list = artists_yaml["artists"]
    # p artists_list

    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

    artists_list.each do |artist|
        artists = RSpotify::Artist.search(artist.to_s)
        artist_found = artists.first
        #puts artist_found.name
        if artist_found
            artist_created = Artist.create({
                name: artist_found.name,
                image: artist_found.images[0]['url'],
                genres: artist_found.genres,
                popularity: artist_found.popularity,
                spotify_url: artist_found.external_urls["spotify"],
                spotify_id: artist_found.id
            })
            artist_created.save!
            
            # genres table
            artist_created.genres.each do |genre|
                new_genre = Genre.

        end
    end
end

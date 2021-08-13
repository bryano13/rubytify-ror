require 'yaml'
require 'rspotify'

namespace :db do
    desc "Empty the db and populates with data from Spotify API"
    task populate: :environment do
        # drop all databases
        # Rake::Task['db:reset'].invoke

        RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
        artists_yaml = YAML.load(File.read('artists.yml'))

        albums_dict = {} # hash that will contain {'artist_id' => '[albums array]'}
        # populate db with artists from spotify API
        artists_yaml['artists'].each do |artist|
            artists = RSpotify::Artist.search(artist.to_s)
            # puts artists.to_json
            artist_fetched = artists.first
            #puts artist_fetched.albums.to_json
            # puts artist_fetched.methods
            # puts artist_fetched.albums.first.tracks.first.name
            if artist_fetched
                new_artist = Artist.create({
                    name: artist_fetched.name,
                    image: artist_fetched.images[0]['url'],
                    genres: artist_fetched.genres,
                    popularity: artist_fetched.popularity,
                    spotify_url: artist_fetched.external_urls['spotify'],
                    spotify_id: artist_fetched.id
                })
                new_artist.save!

                # albums_per_artist is an array of album objects per artist
                albums_per_artist = artist_fetched.albums
                albums_dict[new_artist.id] = albums_per_artist   
            end
        end
        # populate Album table
        for a_id, album_list in albums_dict
            for album in album_list
                puts "#{a_id}: #{album.name}"
                new_album = Album.create({
                    name: album.name,
                    image: album.images[0],
                    total_tracks: album.total_tracks,
                    spotify_url: album.external_urls['spotify'],
                    spotify_id: album.id,
                    artist_id: a_id
                })
                new_album.save!
            end
        end

    end

end
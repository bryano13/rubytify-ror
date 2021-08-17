require 'yaml'
require 'rspotify'

namespace :db do
    desc "Empty the db and populates with data from Spotify API"
    task populate: :environment do
        # drop all databases
        # Rake::Task['db:reset'].invoke

        RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
        artists_yaml = YAML.load(File.read('artists.yml'))

        albums_dict = {} # hash that will contain {'artist_id' => [albums array]}
        songs_dict = {} # hash that will contain {'album_id' => [songs array]}

        # populate db with artists from spotify API
        artists_yaml['artists'].each do |artist|
            sleep(0.3)
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
                sleep(0.3)
                # puts "#{a_id}: #{album.name}"
                new_album = Album.create({
                    name: album.name,
                    image: album.images[0],
                    total_tracks: album.total_tracks,
                    spotify_url: album.external_urls['spotify'],
                    spotify_id: album.id,
                    artist_id: a_id
                })
                new_album.save!
                songs_dict[new_album.id] = album.tracks
                # puts "#{new_album.id}: #{album.tracks}"
            end
        end

        # populate Song table
        for albm_id, song_list in songs_dict
            for song in song_list
                sleep(0.3)
                #puts "#{k}: #{song.name}"
                new_song = Song.create({
                    name: song.name,
                    duration_ms: song.duration_ms,
                    explicit: song.explicit,
                    preview_url: song.preview_url,
                    spotify_url: song.external_urls['spotify'],
                    spotify_id: song.id,
                    album_id: albm_id
                })
                new_song.save!
            end
        end

    end

end

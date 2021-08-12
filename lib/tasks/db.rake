require 'yaml'
require 'rspotify'


desc 'Loads seed artists data => fetchs from Spotify API => populates databases'
task read_file: :environment do
    # Helps reset the data on all databases (to avoid duplicates)
    Rake::Task['db:reset'].invoke

    artists_yaml = YAML.load(File.read('artists.yml'))
    artists_list = artists_yaml["artists"]

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

            artist_found.albums.each do |album|
                album_created = Album.create({
                    name: album.name,
                    image: album.images[0],
                    total_tracks: album.total_tracks,
                    spotify_url: album.external_urls['spotify'],
                    spotify_id: album.id,
                    artist_id: artist_created.id
                })
                album_created.save!

                if album_created
                    album_songs = album.tracks
                    album_songs.each do |song|
                        song_created = Song.create({
                            name: song.name,
                            duration_ms: song.duration_ms,
                            explicit: song.explicit ? song.explicit : false,
                            preview_url: song.preview_url,
                            spotify_url: song.external_urls['spotify'],
                            spotify_id: song.id,
                            album_id: album_created.id
                })
                song_created.save!
                    end
                end
            end
        end
    end
end

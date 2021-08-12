# Rubytify
![rubytify_image](https://github.com/bryano13/git_course/blob/main/Rubutify_logo.png)
## Instructions

- For the rubytify instructions check this gist: https://gist.github.com/AyendaHoteles/235cd0955799dfc1c9ec5fa28d00f2ae 
- To upload the code create your own fork of this repo and start a pull request to this repo once you're done with your changes.


## Rubytiy API

You can request the API hosted in Heroku here:
[API Link](https://bryan-ortiz-rubytify-ayenda.herokuapp.com/api/v1/genres/rock/random_song)


This API has the following endpoints:

- `/api/v1/artists` returns all artists  
- `/api/v1/artists/:id/albums` returns all albums for a given artist  
- `/api/v1/albums/:id/songs` returns all songs for a given album
- `/api/v1/genres/:genre_name/random_song` returns a random song hat matches the specified genre name

### Database

- SQLite  

### Rake Task 

**warning** Running this task will drop all the databases

- Run `rake db:read_file` fetches the Spotify API and populates the Database with artists read from a YAML file. 


Coded with ❤️ and 🔨 by: [Bryan Ortiz Lenis](https://github.com/bryano13)

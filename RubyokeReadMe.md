Welcome to Rubyoke. Have you ever listened to a song and suddenly want to sing along but don’t actually know the lyrics? We built Rubyoke just for those occasions, so that you have access to those lyrics at a moment’s notice. With our app, you can create a playlist, look up lyrics based on the song name and song artist and save the songs to the playlist, or delete them from the playlist later.

For this application we used the Lyrics.OVH API which provides a database of songs and their lyrics.

Our application is illustrated using three models:
- Playlist, which is the playlist you will create upon opening the app.
- Tracklist, which will queue and save the songs that you look up.
- Tracklist is also the join model that connects our playlist model to the song model.
- Song, which are the songs that you will search for.

Domain model:
- Playlist has_many tracklists, has_many songs through tracklists
- Song has_many tracklists, has_many playlists through tracklists
- Tracklist belongs_to Playlist and Song

Installation Instructions:
1. Clone this repository to your local machine and go to the file in your terminal.

2. Run bundle install

3. Run ruby bin/run.rb

4. Follow along in your terminal to enter the artist and song name of your choice.

5. Now you can sing along with your favorite songs!

Licenses
Camille Feghali
David Ren
February 14, 2019

Powered by Lyrics.OVH
https://lyricsovh.docs.apiary.io/

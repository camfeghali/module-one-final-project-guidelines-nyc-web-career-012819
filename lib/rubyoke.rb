
class Rubyoke

  attr_accessor :song, :artist, :lyrics, :user_name

  def greeting
    puts "                        WELCOME TO RUBYOKE!"
    puts "                        WHAT'S YOUR NAME?"
    self.user_name = gets.chomp.strip
  end

  def main_menu
    puts "            HEY #{self.user_name.upcase}! WHAT WOULD YOU LIKE TO DO ?  (pick a number and hit ENTER) "
    puts "                        1 - SING ALONG                       "
    puts "                        2 - SEE MY PLAYLIST                  "
    puts "                        3 - LEAVE RUBYOKE                    "
  end

  def create_playlist
    playlist_name = "#{self.user_name}'s playlist"
    Playlist.create(name: playlist_name)
  end

  def artist_song?
    puts "Who's the artist?"
    self.artist = gets.chomp.strip
    puts "Which song would like to hear?"
    self.song = gets.chomp.strip
  end

  def create_song
    Song.find_or_create_by(name: self.song, artist: self.artist)
  end


  def store_lyrics
    lyrics = LyricsAPI.new(self.song, self.artist).get_lyrics
    Song.update(Song.find_by(name: self.song).id, lyrics: lyrics)
  end

  def display_lyrics
    lyrics = Song.find_by(name: self.song).lyrics
    puts lyrics
  end

  def save_to_playlist?
    puts "Would you like to add this song your playlist?"
    puts "yes/no"
    response = gets.chomp.downcase
    if response == "yes"
      true
    elsif response == "no"
      false
    else
      puts "Please enter a yes or no"
    end
  end

  def to_save_or_not_to_save(answer)
    if answer == true
       self.to_save
    else
      self.not_to_save
    end
  end

  def play_song
    file = './lib/song.mp3'
    pid = fork{ exec 'afplay', file }
  end

  def stop_playing_song
    pid = fork{exec 'killall afplay'}
  end

  def sing_along
    self.artist_song?

    self.create_song

    self.store_lyrics

    self.display_lyrics

    self.play_song

  end

###Helper Methods###
  def to_save
      playlist_id = Playlist.find_by(name: "#{self.user_name}'s playlist").id
      song_id = Song.find_by(name: "#{self.song}").id
      # binding.pry
      Tracklist.create(playlist_id: playlist_id, song_id: song_id)
  end

  def not_to_save
    puts "Ok, pick a new song"
  end


end

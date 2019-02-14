
class Rubyoke

  attr_accessor :song, :artist, :lyrics, :user_name

#Greets the user#
  def greeting
    puts "WELCOME TO RUBYOKE!".rjust(248)
    puts "WHAT'S YOUR NAME?".rjust(247)
    self.user_name = gets.chomp.strip.downcase
    # system "clear"
  end

#Display the main menu#
  def main_menu
    system "clear"
    puts_rubyoke
    puts "HEY #{self.user_name.upcase}! WHAT WOULD YOU LIKE TO DO ?  (pick a number and hit ENTER) ".rjust(277)
    puts "1 - SING ALONG".rjust(247)
    puts "2 - SEE MY PLAYLIST".rjust(252)
    puts "3 - LEAVE RUBYOKE".rjust(250)
  end

#Create a playlist for current user#
  def create_playlist
    playlist_name = "#{self.user_name.downcase}'s playlist"
    Playlist.find_or_create_by(name: playlist_name)
    # system "clear"
  end

#Sing_Along method: Asks for artist and song name#
  def artist_song?
    system "clear"
    puts_rubyoke
    puts "Who's the artist?".upcase.rjust(250)
    self.artist = gets.chomp.strip
    puts "Which song would you like to hear?".upcase.rjust(258)
    self.song = gets.chomp.strip
  end

#Sing_Along method: creates song in Song table#
  def create_song
    Song.find_or_create_by(name: self.song, artist: self.artist)
  end

#Sing_Along method: store lyrics string in Song table#
  def store_lyrics
    lyrics = LyricsAPI.new(self.song, self.artist).get_lyrics
    Song.update(Song.find_by(name: self.song).id, lyrics: lyrics)
  end

#Displays lyrics string#
  def display_lyrics
    lyrics = Song.find_by(name: self.song).lyrics
    system "clear"
    lyrics_scroll(lyrics)
  end

  #Lyrics scroll#
  def lyrics_scroll(lyrics)

      lyrics.each_char do |c|
      print c
      # timer = c.length/10
      sleep (0.0007)
    end
  end

#Sing_Along method: returns true or false for to_save_or_not_to_save method#
  def save_to_playlist?
    system "clear"
    puts_rubyoke
    puts "Would you like to add this song your playlist?".rjust(262)
    puts "yes/no".rjust(244)
    response = gets.chomp.downcase
    if response == "yes"
      true
    elsif response == "no"
      false
    else
      puts "Please enter a yes or no"
    end
  end

#Runs method to save song or not save song#
  def to_save_or_not_to_save(answer)
    if answer == true
       self.to_save
       self.main_menu
    else
      self.not_to_save
      self.main_menu
    end
  end

  def play_song
    file = './lib/dear_friends.mp3'
    pid = fork{ exec 'afplay', file }
  end

  def stop_playing_song
    pid = fork{exec 'killall afplay'}
  end

### Menu Methods ###
  def sing_along

    play = nil

    self.artist_song?

    self.create_song

    self.store_lyrics



    self.play_song
    self.display_lyrics
    puts "\nHit X to got back to menu\n".rjust(245).red

    play = gets.chomp.downcase
    if play == "x"
      self.stop_playing_song
    end
    self.to_save_or_not_to_save(self.save_to_playlist?)
  end

  # def get_my_song_ids
  #   Tracklist.all.map{|track| track.song_id}
  # end

  def get_my_songs_ids
    Tracklist.all.where("playlist_id = #{self.get_user_playlist_id}").map do |track| track.song_id end.uniq
  end

  def get_user_playlist_id
    Playlist.all.find_by(name: "#{self.user_name.downcase}'s playlist").id
  end

  def show_playlist
    system "clear"
    puts_rubyoke
    Song.all.where(id: self.get_my_songs_ids).map do |song|
        puts ("#{song.name},".capitalize + " by " + "#{song.artist}".capitalize).rjust(250) end
  end

  #Playlist method#
  def delete_song(song_name)
    # binding.pry
    Tracklist.delete(Tracklist.all.find_by(song_id: gets_song_id_by_name(song_name)).id)
  end

  def gets_song_id_by_name(name)
    # binding.pry
    Song.all.find_by(name: name).id
  end
###Helper Methods###
  def to_save
      playlist_id = Playlist.find_by(name: "#{self.user_name}'s playlist").id
      song_id = Song.find_by(name: "#{self.song}").id
      # binding.pry
      Tracklist.create(playlist_id: playlist_id, song_id: song_id)
      system "clear"
  end

  def not_to_save
    system "clear"
    puts "                Ok, enter 1 to pick a new song".upcase
  end


end

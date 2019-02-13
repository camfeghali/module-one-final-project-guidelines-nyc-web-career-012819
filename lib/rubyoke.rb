
class Rubyoke

  attr_accessor :song, :artist, :lyrics #:user_name,

  def greeting
    puts "Welcome to Rubyoke"
    # puts "What's your name?"
    # self.user_name = gets.chomp.strip
    # User.find_or_create_by(user_name: self.user_name)
  end

  def artist? #Changed Artist.find to Song.find, name: to artist:
    puts "Who's the artist?"
    self.artist = gets.chomp.strip
    Song.find_or_create_by(artist: artist)
  end

  def song?
    puts "Which song would like to hear?"
    self.song = gets.chomp.strip
    Song.find_or_create_by(name: song)
  end

#Is this necessary now?
  # def assign_artist_to_song
  #   Song.update(Song.find_by(name: self.song).id, artist_id: get_artist_id_by_name)
  # end

#Is this necessary now?
  # def get_artist_id_by_name
  #   Artist.find_by(name: self.artist).id
  # end

  def store_lyrics
    lyrics = LyricsAPI.new(self.song, self.artist).get_lyrics
    Song.update(Song.find_by(name: self.song).id, lyrics: lyrics)
  end

  def display_lyrics
    lyrics = Song.find_by(name: self.song).lyrics
    puts lyrics
  end



end

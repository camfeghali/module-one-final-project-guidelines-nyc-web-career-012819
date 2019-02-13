require_relative '../config/environment'


game = Rubyoke.new

game.greeting

game.create_playlist

game.artist_song?

game.create_song

game.store_lyrics

game.display_lyrics

banana = game.save_to_playlist?

game.to_save_or_not_to_save(banana)

binding.pry

# puts "HELLO WORLD"

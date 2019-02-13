require_relative '../config/environment'


game = Rubyoke.new

game.greeting

game.main_menu

menu_selection = gets.chomp

game.create_playlist


if menu_selection == "1"
  game.sing_along
end



# sleep(60)
#
# game.stop_playing_song

banana = game.save_to_playlist?

game.to_save_or_not_to_save(banana)

binding.pry

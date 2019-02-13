require_relative '../config/environment'

# playing = true
# while playing = true
#
# end

playing = true


game = Rubyoke.new

game.greeting

while playing == true

  game.main_menu

  menu_selection = gets.chomp.to_i

  game.create_playlist

  if menu_selection == 1
    game.sing_along
    menu_selection = gets.chomp.to_i
    if menu_selection == 1
      game.sing_along
    else
      game.main_menu
    end
  elsif menu_selection == 2
    game.show_playlist
    puts "ENTER 5 FOR MAIN MENU"
    puts "ENTER 6 TO DELETE SONG FROM PLAYLIST"

    menu_selection = gets.chomp.to_i
      if menu_selection == 6
        puts "Enter name of the song you want to delete"
        song_name = gets.chomp
        # binding.pry
        game.delete_song(song_name)
        game.show_playlist
      end

  elsif menu_selection == 5
    game.main_menu
    menu_selection = gets.chomp.to_i
  elsif menu_selection == 3
    puts "                            GOODBYE!"
    exit!
  end

end
# binding.pry

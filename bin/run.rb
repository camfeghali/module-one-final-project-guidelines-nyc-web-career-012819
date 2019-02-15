require_relative '../config/environment'




system "clear"

puts_rubyoke

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
    puts "ENTER M FOR MAIN MENU OR D TO DELETE A SONG FROM PLAYLIST".rjust(270)
    menu_selection = gets.chomp.downcase
      if menu_selection == "d"
        puts "Enter name of the song you want to delete".rjust(261).red
        song_name = gets.chomp.downcase
        # binding.pry
        game.delete_song(song_name)
        game.show_playlist
      end
  elsif menu_selection == "m"
    game.main_menu
    menu_selection = gets.chomp.to_i
  elsif menu_selection == 3
    system "clear"
    puts_goodbye
    exit!
  end

end

class Main
  def open_file(file)
    file = file.foreach('games.log').first
    puts file
  end
end

Main.new.open_file("games.log")
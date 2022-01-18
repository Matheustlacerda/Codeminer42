require_relative "lib/read_file"

file = ReadFile.new.open_file("games.log")

puts file

require_relative "lib/log_parser"

file = LogParser.new('games.log')

puts file.read_first_line

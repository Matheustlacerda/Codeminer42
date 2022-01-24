require_relative "lib/log_parser"

file = LogParser.new('games.log')

puts file.read_first_line

puts JSON.pretty_generate(file.json_output)


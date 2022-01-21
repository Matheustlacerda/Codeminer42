require 'json'

class LogParser
  def initialize(file_path)
    @file_path = file_path
    unless File.exist?(@file_path)
      raise StandardError.new "File not found"
    end
  end

  def read_first_line
    File.readlines(@file_path).first
  end

  def json_output
    {
      "#{@file_path}": {
      "lines": lines_counter,
      "players": players
      }
    }
    end

  private

  def lines_counter
    File.readlines(@file_path).count
  end

  def players
    game_players = []
    File.readlines(@file_path).each do |line|
      if line.include? 'killed' then
        game_players << line.split('killed')[0].split(':').last.strip
        game_players << line.split('killed')[1].split('by').first.strip
      end
    end
    game_players = game_players.uniq
    if game_players.include? '<world>' then
      game_players.delete_at(game_players.index('<world>'))
    end
    game_players
  end
end

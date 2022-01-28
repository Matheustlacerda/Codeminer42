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
      "players": players,
      "kills": kills,
      "total_kills": total_kill
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

  def players_kill
    player_kill = []
    File.readlines(@file_path).each do |line|
      if line.include? 'killed' then
        if line.split('killed')[0].split(':').last.strip.include? '<world>' then
          next
        else
          player_kill << line.split('killed')[0].split(':').last.strip
        end
      end
    end
    player_kill.tally
  end

  def world_kill
    world_killed = []
    File.readlines(@file_path).each do |line|
      if line.include? 'killed' then
        if line.split('killed')[0].split(':').last.strip.include? '<world>' then
          world_killed << line.split('killed')[1].split('by').first.strip
        end
      end
    end
    world_killed.tally
  end

  def kill_itself
    kill = []
    File.readlines(@file_path).each do |line|
      if line.include? 'killed' then
        if line.split('killed')[0].split(':').last.strip == line.split('killed')[1].split('by').first.strip
          kill << line.split('killed')[0].split(':').last.strip
        end
      end
    end
    kill.tally
  end
  
  def kills
    kills_counter = {}
    players_kill.each do |player, number_kill|
      world_kill.each do |player1, number_kill1|
        if player == player1
          kills_counter[player] = number_kill - number_kill1
        end
      end
    end
    kills_counter.each do |player, number_kill|
      kill_itself.each do |player1, number_kill1|
        if player == player1
          kills_counter[player] = number_kill - number_kill1
        end
      end
    end
    kills_counter
  end

  def total_kill
    File.readlines(@file_path).select do |line|
      (line.include? 'killed') && (!line.split('killed')[0]
                                        .split(':')
                                        .last.strip.include? '<world>')
    end.size
  end
end

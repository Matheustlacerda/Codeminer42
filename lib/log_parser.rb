require 'json'

class LogParser
  def initialize(file_path)
    @file_path = file_path
    raise StandardError, 'File not found' unless File.exist?(@file_path)
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

  def lines_counter
    File.readlines(@file_path).count
  end

  def players
    game_players = []
    File.readlines(@file_path).each do |line|
      if line.include? 'killed'
        game_players << line.split('killed')[0].split(':').last.strip
        game_players << line.split('killed')[1].split('by').first.strip
      end
    end
    game_players = game_players.uniq
    game_players.delete('<world>') if game_players.include? '<world>'
    game_players
  end

  def players_kill
    player_kill = []
    File.readlines(@file_path).each do |line|
      if line.include? 'killed'
        if line.split('killed')[0].split(':').last.strip.include? '<world>'
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
      next unless line.include? 'killed'

      if line.split('killed')[0].split(':').last.strip.include? '<world>'
        world_killed << line.split('killed')[1].split('by').first.strip
      end
    end
    world_killed.tally
  end

  def kill_itself
    kill = []
    kill2 = {}
    File.readlines(@file_path).each do |line|
      next unless line.include? 'killed'

      if line.split('killed')[0].split(':').last.strip == line.split('killed')[1].split('by').first.strip
        kill << line.split('killed')[0].split(':').last.strip
      end
    end
    kill.tally.map { |key, value| kill2[key] = value * 2 }
    kill2
  end

  def kills
    kills_score = {}
    players.each { |player| kills_score[player] = 0 }
    kills_score.merge(players_kill) { |key, v1, v2| kills_score[key] = v1 + v2 }
    kills_score.merge(world_kill) { |key, v1, v2| kills_score[key] = v1 - v2 }
    kills_score.merge(kill_itself) { |key, v1, v2| kills_score[key] = v1 - v2 }
  end

  def total_kill
    File.readlines(@file_path).select do |line|
      line.include? 'killed'
    end.size
  end
end

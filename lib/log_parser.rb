require 'json'

class LogParser
  def initialize(file)
    @file = file
    unless File.exist?(@file)
      raise StandardError.new "File not found"
    end
  end
    
  def read_first_line
      File.readlines(@file).first
  end

  def lines_counter
    File.readlines(@file).count
  end

  def json_output
    data = {
      "#{@file}": {
      "lines": lines_counter
      }
    }
    end
end

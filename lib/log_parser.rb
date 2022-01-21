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
      "lines": lines_counter
      }
    }
    end

  private

  def lines_counter
    File.readlines(@file_path).count
  end
end

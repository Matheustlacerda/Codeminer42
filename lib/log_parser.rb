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
end

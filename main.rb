class Main
  def open_file(file)
    if File.exist?(file)
      File.readlines(file).first.strip
    else
      return 'error: not the right file'
    end
  end
end
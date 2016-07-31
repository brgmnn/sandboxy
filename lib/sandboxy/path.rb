class Sandboxy::Path
  attr_reader :extension, :file, :filename

  def initialize(path)
    @extension = File.extname(path)[1..-1]
    @file = File.basename(path)
    @filename = File.basename(@file,File.extname(@file))
  end

  def info
    return @file, @filename, @extension
  end
end

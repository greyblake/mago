module Mago
  class FileFinder
    def initialize(paths)
      @paths = paths
    end

    def find
      ruby_files = []

      @paths.each do |path|
        if File.directory?(path)
          pattern = File.join(path, '/**/*.rb')
          ruby_files.concat(Dir[pattern])
        else
          ruby_files << path
        end
      end

      ruby_files
    end
  end
end

module Mago
  class FileFinder
    def initialize(paths)
      @paths = paths
    end

    def find
      file_paths = []

      @paths.each do |path|
        if File.directory?(path)
          dir_files = Dir["#{path}/**/*.rb"]
          file_paths.concat(dir_files)
        else
          file_paths << path
        end
      end

      file_paths
    end
  end
end

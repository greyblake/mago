module Mago
  module Cli
    # Finds ruby files in local file system.
    class FileFinder
      # @param paths [Array<String>] files and directories
      def initialize(paths)
        @paths = paths
      end

      # Find ruby files.
      #
      # @return [Array<String>] ruby files
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
end

module Mago
  module Cli
    # Command config. Build by option parser and is used to execute command.
    class Config
      # @attribute files [Array<String>] ruby files to process
      attr_accessor :files

      # @attribute ignore [Array<Numeric>, nil] numbers which must be ignored
      attr_accessor :ignore

      # @attribute color [Boolean] whether colorize output or not
      attr_accessor :color

      # attribute source [Boolean] whether show lines of source
      #   code with magic number or not
      attr_accessor :source

      def initialize
        @files  = []
        @color  = false
        @source = false
        @ignore = nil
      end
    end
  end
end

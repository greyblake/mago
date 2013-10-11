module Mago
  module Cli
    class Config
      attr_accessor :ignore, :files, :color, :source

      def initialize
        @files = []
        @color = false
        @source = false
      end
    end
  end
end

module Mago
  # Represents a ruby file with magic numbers.
  class RubyFile
    # @attribute path [String] file path
    attr_reader :path

    # @attribute magic_numbers [Array<Mago::MagicNumber>] magic numbers
    attr_reader :magic_numbers

    # @param path [String] file path
    def initialize(path)
      @path = path
      @magic_numbers = []
    end
  end
end

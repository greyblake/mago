module Mago
  # Magic number. Contains value of number and line number of source code.
  class MagicNumber
    # @attribute value [Numeric] magic number itself
    attr_accessor :value

    # @attribute line [Integer] line of source file where the magic number is located
    attr_accessor :line

    # @param attrs [Hash]
    def initialize(attrs = {})
      @value = attrs[:value]
      @line  = attrs[:line]
    end
  end
end

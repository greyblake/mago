module Mago
  class RubyFile
    attr_reader :path, :magic_numbers

    def initialize(path)
      @path = path
      @magic_numbers = []
    end
  end
end

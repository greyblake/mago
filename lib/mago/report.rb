module Mago
  class Report
    attr_reader :files, :errors

    def initialize
      @files = []
      @errors = []
    end
  end
end

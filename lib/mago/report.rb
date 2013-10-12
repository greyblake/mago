module Mago
  # Work report built by {Mago::Detector}.
  class Report
    # @attribute files [Array<Mago::File>]
    attr_reader :files

    # @attribute errors [Array<String>]
    attr_reader :errors

    def initialize
      @files  = []
      @errors = []
    end
  end
end

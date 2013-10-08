module Mago
  class SexpProcessor < ::SexpProcessor

    def initialize(file, ignore = [])
      super()
      self.warn_on_default = false
      self.strict = false

      @file   = file
      @ignore = ignore
    end

    def process_cdecl(exp)
      process_default(exp)
    end

    def process_lit(exp)
      exp.shift
      value = exp.shift

      if value.is_a?(Numeric) && !@ignore.include?(value)
        @file.magic_numbers << MagicNumber.new(:value => value, :line => exp.line)
      end

      s()
    end

    def process_default(exp)
      until exp.size == 0
        exp.shift
      end
      s()
    end

  end
end


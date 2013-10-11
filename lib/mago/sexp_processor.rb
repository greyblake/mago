module Mago
  # The core of Mago.
  # Iterates through AST returned by RubyParser and finds numeric literals.
  class SexpProcessor < ::SexpProcessor
    # @param file [Mago::File] file where found numbers will be stored
    # @param ignore [Array<Numeric>] array of numbers to ignore
    def initialize(file, ignore = [])
      super()
      self.warn_on_default = false
      self.strict = false

      @file   = file
      @ignore = ignore
    end

    # Process constant declaration node. It's the case where we
    # numeric literals, because they are not magic numbers.
    #
    # @param exp [Sexp]
    #
    # @return [Sexp]
    def process_cdecl(exp)
      process_default(exp)
    end

    # Process literal node. If a literal is a number and add it to the
    # collection of magic numbers.
    #
    # @param exp [Sexp]
    #
    # @return [Sexp]
    def process_lit(exp)
      exp.shift
      value = exp.shift

      if value.is_a?(Numeric) && !@ignore.include?(value)
        @file.magic_numbers << MagicNumber.new(:value => value, :line => exp.line)
      end

      s()
    end

    # Handler for all other nodes. They doesn't interest us, so we just skip.
    #
    # @param exp [Sexp]
    #
    # @return [Sexp]
    def process_default(exp)
      until exp.size == 0
        exp.shift
      end
      s()
    end
  end
end


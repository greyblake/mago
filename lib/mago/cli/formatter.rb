module Mago
  module Cli
    # Formats report to be printed
    class Formatter
      include Colorize

      # @param opts [Hash]
      #
      # @option opts :color [Boolean] whether colorize output or no
      def initialize(opts = {})
        @color = opts[:color]
      end

      # Format report.
      #
      # @param report [Mago::Report]
      #
      # @return [String] formated report
      def format(report)
        out = ''

        report.files.each do |file|
          out << format_file(file, out)
        end

        report.errors.each do |error|
          out << format_error(error)
        end

        out
      end


      # Format file with magic numbers.
      #
      # @param file [Mago::File]
      #
      # @return [void]
      def format_file(file)
        out = ''

        file.magic_numbers.each do |num|
          if @color
            val  = red(num.value)
            line = yellow(num.line)
            path = pink(file.path)
          else
            val  = num.value
            line = num.line
            path = file.path
          end

          out << "#{path}:#{line} detected magic number #{val}\n"
        end

        out
      end

      # Format error.
      #
      # @param error [String] error message
      #
      # @return [void]
      def format_error(error)
        out = "ERROR: #{error}"
        @color ? red(out) : out
      end
    end
  end
end

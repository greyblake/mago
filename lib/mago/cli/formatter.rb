module Mago
  module Cli
    # Formats report to be printed
    class Formatter
      include Colorize

      # @param report [Mago::Report]
      # @param opts [Hash]
      #
      # @option opts :color [Boolean] whether colorize output or no
      def initialize(report, opts = {})
        @report = report
        @color  = opts[:color]
      end

      # Format report.
      #
      # @return [String] formated report
      def format
        out = ''

        @report.files.each do |file|
          format_file(file, out)
        end

        @report.errors.each do |error|
          format_error(error, out)
        end

        out
      end


      private

      # Format file with magic numbers.
      #
      # @param file [Mago::File]
      # @param out [String] string to write result
      #
      # @return [void]
      def format_file(file, out)
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
      end

      # Format error.
      #
      # @param error [String] error message
      # @param out [String] string to write result
      #
      # @return [void]
      def format_error(error, out)
        out << "ERROR: %s\n" % [error]
      end
    end
  end
end

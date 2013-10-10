module Mago
  module Cli
    class Formatter
      include Colorize

      def initialize(report, opts = {})
        @report = report

        @color = opts[:color]
      end

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

      def format_error(error, out)
        out << "ERROR: %s\n" % [error]
      end
    end
  end
end

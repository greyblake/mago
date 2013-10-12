module Mago
  module Cli
    # Formats report showing lines of source code where magic number was detected.
    class SourceFormatter < Formatter
      # :nodoc:
      def format_file(file)
        out = ''
        source_lines = File.readlines(file.path)

        file.magic_numbers.each do |num|
          if @color
            line = yellow(num.line)
            path = pink(file.path)
            source_line = make_red(source_lines[num.line-1], num.value.to_s)
          else
            line = num.line
            path = file.path
            source_line = source_lines[num.line-1]
          end

          out << "#{path}:#{line}| #{source_line}"
        end

        out
      end

      # Find a substing in a string and make it red.
      #
      # @param str [String]
      # @param substr [String]
      #
      # @return [String] string with red substring
      def make_red(str, substr)
        chunks = str.split(substr)
        chunks.join(red(substr))
      end
    end
  end
end

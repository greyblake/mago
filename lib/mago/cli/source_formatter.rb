module Mago
  module Cli
    class SourceFormatter < Formatter
      def format_file(file, out)
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
      end

      def make_red(str, substr)
        chunks = str.split(substr)
        chunks.join(red(substr))
      end
    end
  end
end

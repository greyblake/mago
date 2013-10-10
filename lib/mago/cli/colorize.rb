module Mago
  module Cli
    module Colorize
      def colorize(text, color_code)
        "\e[#{color_code}m#{text}\e[0m"
      end

      def red(text)
        colorize(text, 31)
      end

      def green(text)
        colorize(text, 32)
      end

      def yellow(text)
        colorize(text, 33)
      end

      def pink(text)
        colorize(text, 35)
      end
    end
  end
end

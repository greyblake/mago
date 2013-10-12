module Mago
  module Cli
    # Provides methods to colorize strings with ANSI colors.
    module Colorize
      # Colorize text using a passed code
      #
      # @param text [String]
      # @param color_code [Integer]
      #
      # @return [String] colorized text
      def colorize(text, color_code)
        "\e[#{color_code}m#{text}\e[0m"
      end

      # :nodoc:
      def red(text)
        colorize(text, 31)
      end

      # :nodoc:
      def green(text)
        colorize(text, 32)
      end

      # :nodoc:
      def yellow(text)
        colorize(text, 33)
      end

      # :nodoc:
      def pink(text)
        colorize(text, 35)
      end
    end
  end
end

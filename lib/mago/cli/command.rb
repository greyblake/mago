module Mago
  module Cli
    # CLI command.
    #
    # @example
    #   command = Mago::Cli::Command('-s', '-i', '0,1,2', './lib')
    #   command.execute
    class Command
      # @param arguments [Array<String>] command arguments
      def initialize(arguments)
        @arguments = arguments
        @config    = Config.new
      end

      # Execute command.
      #
      # @return [void]
      def execute
        parse_arguments
        run
      end



      private

      # Parse arguments and build config.
      #
      # @return [void]
      def parse_arguments
        while arg = @arguments.shift
          case arg
          when /^--/
            process_option(arg)
          when /^-/
            arg[1..-1].each_char {|opt| process_option("-#{opt}") }
          else
            @config.files << arg
          end
        end

        @config.files << '.' if @config.files.empty?
      end

      # Process option.
      #
      # @param option [String] option
      #
      # @return [void]
      def process_option(option)
        case option
        when '--help', '-h'
          print_help
          exit 0
        when '--version', '-v'
          print_version
          exit 0
        when '--ignore', '-i'
          val = @arguments.shift
          abort "#{option} option requires comma separated numbers" unless val =~ /^[0-9]/
          nums = val.to_s.split(',').map{ |n| n.include?('.') ? n.to_f : n.to_i }
          @config.ignore = nums
        when '--color', '--colour', '-c'
          @config.color = true
        when '--source', '-s'
          @config.source = true
        else /^-/
          abort("Unknown option `#{option}'")
        end
      end

      # Run command using settings from config.
      #
      # @return [void]
      def run
        ruby_files = Mago::Cli::FileFinder.new(@config.files).find
        detector   = Mago::Detector.new(ruby_files, :ignore => @config.ignore)

        formatter_class = @config.source ? SourceFormatter : Formatter
        formatter  = formatter_class.new(:color => @config.color)

        detector.on_file do |file|
          print formatter.format_file(file)
        end

        detector.on_error do |error|
          warn formatter.format_error(error)
        end

        detector.run
      end

      # Show help message.
      #
      # @return [void]
      def print_help
        puts <<-HELP
Magic numbers detector for Ruby programming language.

  Syntax:
    mago [OPTIONS] [FILES]

  Options:
    -i, --ignore NUMS
        Comma separated numbers, which will be ignored. Default is 0,1

    -c, --color
        Colorize output

    -s, --source
        Show a line of source code with a magic number

  Usage:
    mago
    mago -i 2,5 ./my_code.rb
    mago -cs ./my_project/
        HELP
      end


      # Show program version.
      #
      # @return [void]
      def print_version
        puts <<-TEXT
Mago #{Mago::VERSION}
Tool to detect magic numbers in ruby files.
Copyright (c) 2013 Sergey Potapov
        TEXT
      end

    end
  end
end

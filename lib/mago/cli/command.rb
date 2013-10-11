module Mago
  module Cli
    class Config
      attr_accessor :ignore, :files, :color, :source

      def initialize
        @files = []
        @color = false
        @source = false
      end
    end

    class Command
      def initialize(args)
        @args = args
        @config = Config.new
      end

      def execute
        parse_args
        run
      end

      def parse_args
        while arg = @args.shift
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

      def process_option(option)
        case option
        when '--help', '-h'
          show_help
          exit 0
        when '--version', '-v'
          show_version
          exit 0
        when '--ignore', '-i'
          val = @args.shift
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


      private

      def run
        ruby_files = Mago::FileFinder.new(@config.files).find
        detector   = Mago::Detector.new(ruby_files, :ignore => @config.ignore)
        report     = detector.run

        formatter_class = @config.source ? SourceFormatter : Formatter
        formatter  = formatter_class.new(report, :color => @config.color)

        puts formatter.format
      end

      def show_help
        puts "Magic numbers detector for Ruby programming language.\n\n" \
             "  Syntax:\n" \
             "    mago [OPTIONS] [FILES]\n\n" \
             "  Options:\n" \
             "    -i, --ignore NUMS\n" \
             "        Comma separated numbers, which will be ignored. Default is 0,1\n\n" \
             "    -c, --color\n" \
             "        Colorize output\n\n" \
             "    -s, --source\n" \
             "        Show a line of source code with a magic number\n\n" \
             "  Usage:\n" \
             "    mago                     # inspect ruby files in current directory\n" \
             "    mago ./my_code.rb        # inspect ./my_code.rb file\n" \
             "    mago ./my_project/       # inspect ruby files in ./my_project/"
      end


      def show_version
        puts "Mago #{Mago::VERSION}\n" \
             "Tool to detect magic numbers in ruby files.\n" \
             "Copyright (c) 2013 Sergey Potapov"
      end

    end
  end
end

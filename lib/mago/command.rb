module Mago
  class Command

    def initialize(args)
      @args = args
    end

    def execute
      case @args.first
      when '--help', '-h'
        show_help
      when '--version', '-v'
        show_version
      else
        run
      end
    end


    private

    def run
      if @args.empty?
        @args << '.'
      end

      ruby_files = Mago::FileFinder.new(@args).find
      detector   = Mago::Detector.new(ruby_files, :ignore => [0, 1])
      report     = detector.run
      formatter  = Mago::Formatter.new(report)

      puts formatter.format
    end

    def show_help
      puts "Description:\n" \
           "    Magic numbers detector for ruby\n\n"\
           "Usage:\n" \
           "   mago                     # inspect ruby files in current directory\n" \
           "   mago ./my_code.rb        # inspect ./my_code.rb file\n" \
           "   mago ./my_project/       # inspect ruby files in ./my_project/"
    end


    def show_version
      puts "Mago #{Mago::VERSION}\n" \
           "Tool to detect magic numbers in ruby files.\n" \
           "Copyright (c) 2013 Sergey Potapov"
    end

  end
end

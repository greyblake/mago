module Mago
  # Magic numbers detector.
  #
  # @example
  #   detector = Mago::Detector.new('./Rakefile', './lib')
  #   detector.run # => #<Mago::Report ...>
  class Detector
    # Numbers which are ignored by default
    DEFAULT_IGNORE = [0, 1]

    # @param file_paths [String] ruby files
    # @param options [Hash]
    #
    # @option options :ignore [Array<Numeric>] numbers which must be ignored
    def initialize(file_paths = [], options = {})
      @file_paths = file_paths
      @report = Report.new
      @ignore = options[:ignore] || DEFAULT_IGNORE
    end

    # Process files and build a report.
    #
    # @return [Mago::Report]
    def run
      @file_paths.each do |path|
        process_file(path)
      end
      @report
    end

    # Set callback to be called when file processing is finished.
    def on_file(&block)
      @on_file = block
    end

    # Set callback to be called when error occurs.
    def on_error(&block)
      @on_error = block
    end


    private

    # Process a file and add a result to the report.
    #
    # @param path [String]
    #
    # @return [void]
    def process_file(path)
      code      = File.read(path)
      sexp_node = RubyParser.new.parse(code)
      file      = Mago::RubyFile.new(path)

      sexp_processor = Mago::SexpProcessor.new(file, @ignore)
      sexp_processor.process(sexp_node)

      @report.files << file
      @on_file.call(file) if @on_file
    rescue Errno::ENOENT => err
      @report.errors << err.message
    rescue Racc::ParseError => err
      msg = "#{path} has invalid ruby code. " << err.message
      @on_error.call(msg) if @on_error
      @report.errors << msg
    end
  end
end

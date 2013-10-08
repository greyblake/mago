module Mago
  class Detector
    def initialize(file_paths = [], options = {})
      @file_paths = file_paths
      @report = Report.new
      @ignore = options[:ignore] || []
    end

    def run
      @file_paths.each do |path|
        process_file(path)
      end
      @report
    end

    def process_file(path)
      code = File.read(path)
      sexp_node = RubyParser.new.parse(code)

      file = Mago::RubyFile.new(path)

      sexp_processor = Mago::SexpProcessor.new(file, @ignore)
      sexp_processor.process sexp_node

      @report.files << file
    rescue Errno::ENOENT => err
      @report.errors << err.message
    rescue Racc::ParseError => err
      msg = "#{path} has invalid ruby code. " << err.message
      @report.errors << msg
    end
  end
end

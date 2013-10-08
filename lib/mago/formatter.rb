module Mago
  class Formatter
    def initialize(report)
      @report = report
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
        out << "%s:%d detected magic number %s\n" % [file.path, num.line, num.value]
      end
    end

    def format_error(error, out)
      out << "ERROR: %s\n" % [error]
    end
  end
end

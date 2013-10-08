module Mago
  class MagicNumber
    attr_accessor :value
    attr_accessor :line
    attr_accessor :file

    def initialize(attrs = {})
      attrs.each do |attr, value|
        send("#{attr}=", value)
      end
    end

  end
end

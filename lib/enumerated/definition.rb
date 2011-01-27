module Enumerated

  # Wraps single enumerated definition declared in model.
  class Definition

    def initialize(declaration)
      if declaration.is_a?(Array)
        @declaration = declaration
      elsif declaration.is_a?(Hash)
        @declaration = declaration.invert
      else
        raise ArgumentError, "Declared enumeration must be either Array or Hash."
      end
    end

    def to_a
      return @declaration.to_a if @declaration.is_a?(Hash)
      result = []
      @declaration.each do |d|
        result << [d.to_s.humanize, d]
      end
      result
    end
  end

end
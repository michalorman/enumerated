module Enumerated

  # Wraps single enumerated definition declared in model.
  class Definition

    def initialize(declaration)
      if declaration.is_a?(Array)
        @declaration = to_h(declaration)
      elsif declaration.is_a?(Hash)
        @declaration = declaration.invert
      else
        raise ArgumentError, "Declared enumeration must be either Array or Hash."
      end
    end

    def to_a
      @declaration.to_a
    end

    private

    def to_h(array)
      hash = Hash.new
      array.each do |a|
        hash[a.to_s.humanize] = a
      end
      hash
    end
  end

end
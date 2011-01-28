module Enumerated

  # Wraps single enumerated definition declared in model.
  class Definition

    def initialize(model, attribute, declaration)
      @model, @attribute, @declaration = model, attribute, declaration
      raise ArgumentError, "Declared enumeration must be either Array or Hash." unless declaration.is_a?(Array) || declaration.is_a?(Hash)
    end

    def to_a(opts = {})
      result = filtered for_select, opts
      ordered result, opts
    end

    def label(key)
      @declaration.is_a?(Hash) ? @declaration[key.to_sym] : resolve_label(key)
    end

    private

    def resolve_label(key)
      I18n.t key.to_s, :default => key.to_s.humanize, :scope => %w(activerecord enumerations) + [@model.downcase, @attribute]
    end

    def for_select
      return @declaration.invert.to_a if @declaration.is_a?(Hash)
      result = []
      @declaration.each do |d|
        result << [resolve_label(d), d]
      end
      result
    end

    def ordered(arr, opts)
      return arr if opts.empty? || !opts.include?(:order)
      ordered = []
      opts[:order].each do |o|
        ordered << arr.select { |a| a[1].to_sym == o.to_sym }[0]
      end
      ordered
    end

    def filtered(arr, opts)
      return arr if opts.empty? || !(opts.include?(:except) || opts.include?(:only))
      raise ArgumentError, "Cannot pass both :except and :only parameters!" if opts.include?(:except) && opts.include?(:only)
      opts.include?(:except) ? except(arr, opts[:except]) : only(arr, opts[:only])
    end

    def except(arr, keys)
      arr.reject { |a| keys.map(&:to_sym).include?(a[1].to_sym) }
    end

    def only(arr, keys)
      arr.select { |a| keys.map(&:to_sym).include?(a[1].to_sym) }
    end
  end

end
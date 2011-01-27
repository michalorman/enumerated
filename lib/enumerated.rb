require 'active_support'
require 'active_record'

module Enumerated
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    # Declares that given attribute is enumerated.
    def enumerated(attr, enums, opts = {})
      # Prepare the declared enumerations
      enums = prepare_declared_enumerations(attr, enums)

      class_eval do
        @enums ||= {}
        @enums[attr.to_sym] = enums
      end

      define_helper_methods(attr, enums, opts)
    end

    private

    def prepare_declared_enumerations(attr, enums)
      return to_h(enums) if enums.is_a?(Array)
      return enums.invert if enums.is_a?(Hash)
      raise ArgumentError, "Declared #{attr} in class #{self} as enumeration with missing enumerations or neither as an Array nor Hash."
    end

    def to_h(array)
      hash = Hash.new
      array.each do |a|
        hash[a.to_s.humanize] = a
      end
      hash
    end

    def define_helper_methods(attr, enums, opts)
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def self.#{attr.to_s.pluralize}
          @enums[:#{attr.to_s}].to_a
        end
      EOS
    end
  end
end

ActiveRecord::Base.send(:include, Enumerated)
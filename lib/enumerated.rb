require 'active_support'
require 'active_record'

require 'enumerated/definition'

module Enumerated
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    # Declares that given attribute is enumerated.
    def enumerated(attr, enums, opts = {})
      class_eval do
        @definitions ||= {}
        @definitions[attr.to_sym] = Definition.new(enums)
      end

      define_helper_methods(attr, enums, opts)
    end

    private

    def define_helper_methods(attr, enums, opts)
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def self.#{attr.to_s.pluralize}
          @definitions[:#{attr.to_s}].to_a
        end
      EOS
    end
  end
end

ActiveRecord::Base.send(:include, Enumerated)
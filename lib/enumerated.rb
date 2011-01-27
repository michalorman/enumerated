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

      define_helper_methods(attr, opts)
      define_label_methods(attr)
    end

    private

    def define_helper_methods(attr, opts)
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def self.#{attr.to_s.pluralize}
          @definitions[:#{attr.to_s}].to_a
        end
        def self.definitions
          @definitions
        end
      EOS

      unless opts.include?(:helper) && !opts[:helper]
        helper = opts[:helper] || "#{self.to_s.pluralize}Helper".constantize
        helper.class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{self.to_s.underscore}_#{attr.to_s.pluralize}
            #{self.to_s}.#{attr.to_s.pluralize}
          end
        EOS
      end
    end

    def define_label_methods(attr)
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def #{attr.to_s}_label
          return nil unless self.class.definitions.include? :#{attr.to_s}
          self.class.definitions[:#{attr.to_s}].label(#{attr})
        end
      EOS
    end
  end
end

ActiveRecord::Base.send(:include, Enumerated)
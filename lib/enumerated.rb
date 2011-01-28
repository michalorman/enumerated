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
      def opts.disabled?(sym)
        include?(sym) && !self[sym]
      end

      class_eval do
        @definitions ||= {}
        @definitions[attr.to_sym] = Definition.new(self.to_s, attr.to_s, enums)
      end

      define_helper_methods(attr, opts)
      define_label_methods(attr)
      define_bang_methods(attr, enums)
      apply_validations(attr, enums, opts)
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
        helper = opts[:helper] || "#{self.to_s.pluralize}Helper"
        if helper.is_a?(Module) || Object.const_defined?(helper.to_sym, false)
          helper = helper.constantize unless helper.is_a?(Module)
          helper.class_eval(<<-EOS, __FILE__, __LINE__ + 1)
            def #{self.to_s.underscore}_#{attr.to_s.pluralize}
              #{self.to_s}.#{attr.to_s.pluralize}
            end
          EOS
        end
      end
    end

    def define_label_methods(attr)
      class_eval(<<-EOS, __FILE__, __LINE__ + 1)
        def #{attr.to_s}_label
          return nil unless self.class.definitions.include?(:#{attr.to_s}) && !#{attr}.blank?
          self.class.definitions[:#{attr.to_s}].label(#{attr})
        end
      EOS
    end

    def define_bang_methods(attr, enums)
      keys(enums).map(&:to_sym).each do |e|
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{e}?
            #{attr}.to_sym == :#{e}
          end
          def #{e}!
            self.#{attr} = :#{e}
          end
        EOS
      end
    end

    def keys(collection)
      collection.is_a?(Array) ? collection : collection.keys
    end

    def apply_validations(attr, enums, opts)
      unless opts.disabled?(:validate)
        inclusion = opts.disabled?(:nillable) ?
            "#{keys(enums).map(&:to_sym).to_s} + #{keys(enums).map(&:to_s).to_s}" :
            "[nil, ''] + #{keys(enums).map(&:to_sym).to_s} + #{keys(enums).map(&:to_s).to_s}"
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          validates :#{attr.to_s}, :inclusion => #{inclusion}
        EOS
      end
    end
  end
end

ActiveRecord::Base.send(:include, Enumerated)
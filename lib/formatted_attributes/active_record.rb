module FormattedAttributes
  module ActiveRecord
    def self.included(base)
      base.instance_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def formatted(*args)
        options = args.extract_options!

        args.each do |attr|
          class_eval <<-RUBY
            def #{attr}=(value)
              @formatted_#{attr} = nil
              write_attribute :#{attr}, value
            end

            def formatted_#{attr}
              @formatted_#{attr} ||= format_from_#{options[:with]}(send(:#{attr}))
            end

            def formatted_#{attr}=(value)
              self.send :#{attr}=, format_to_#{options[:with]}(value)
              @formatted_#{attr} = value
            end
          RUBY
        end
      end
    end
  end
end

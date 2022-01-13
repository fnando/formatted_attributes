# frozen_string_literal: true

module FormattedAttributes
  require "formatted_attributes/version"

  def self.included(base)
    base.instance_eval do
      extend ClassMethods
    end
  end

  module ClassMethods
    def formatted(*args)
      options = args.extract_options!
      formatter = options[:with]

      extension = Module.new do
        args.each do |attr|
          formatted_attr = :"@formatted_#{attr}"

          # Overwrite attribute setter.
          # This will clear the formatted attribute's cache.
          #
          # The reason we're using `prepend extension` is that ActiveRecord's
          # attributes aren't defined upfront, so we can't retrieve a method
          # reference with `instance_method(attr)` to use on this overwriting
          # method, forcing us to call `super` instead. The downside of this
          # approach is that each attribute will include a new module, but for
          # most cases that won't be a problem.
          define_method("#{attr}=") do |value|
            instance_variable_set(formatted_attr, nil)
            super(value)
          end

          # Create the formatted attribute reader.
          # This method will read the raw value and convert it to the formatted
          # value by calling `format_to_{formatter}`.
          define_method("formatted_#{attr}") do
            formatted_value = instance_variable_get(formatted_attr)

            return formatted_value if formatted_value

            instance_variable_set(
              formatted_attr,
              send(:"convert_with_#{formatter}", send(attr))
            )
          end

          # Create the formatted attribute setter.
          # This method will receive a formatted value and coerce it into the
          # expected format by calling `format_from_{formatter}`.
          define_method("formatted_#{attr}=") do |formatted_value|
            send(
              :"#{attr}=",
              send(:"convert_from_#{formatter}", formatted_value)
            )
          end
        end
      end

      prepend extension
    end

    alias formatted_attribute formatted
  end
end

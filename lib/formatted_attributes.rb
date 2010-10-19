require "active_record"
require "formatted_attributes/active_record"
require "formatted_attributes/version"

ActiveRecord::Base.send :include, FormattedAttributes::ActiveRecord

# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter "/test/"
end

require "bundler/setup"
require "formatted_attributes"
require "active_record"
require "action_view/helpers/number_helper"

require "minitest/utils"
require "minitest/autorun"

ActiveRecord::Base.establish_connection("sqlite3::memory:")

Dir["#{__dir__}/support/**/*.rb"].sort.each do |file|
  require file
end

ActiveRecord::Schema.define(version: 0) do
  create_table :products do |t|
    t.integer :price, :shipping, default: 0, null: false
  end
end

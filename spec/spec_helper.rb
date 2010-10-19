require "formatted_attributes"
require "active_support/all"
require "action_view/helpers/number_helper"

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"

load File.dirname(__FILE__) + "/schema.rb"

class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  formatted :price, :shipping, :with => :cents

  validates_numericality_of :price, :shipping, :only_integer => true

  private
  def format_to_cents(number)
    _, operator, number, precision = *number.to_s.match(/^([+-])?(\d+)(?:[,.](\d+))?$/)
    (BigDecimal("#{operator}#{number}.#{precision.to_i}") * 100).to_i
  end

  def format_from_cents(number)
    number = BigDecimal(number.to_s) / 100
    number_to_currency(number, :unit => "", :separator => ",", :delimiter => "")
  end
end

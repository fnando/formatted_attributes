# frozen_string_literal: true

class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  include FormattedAttributes
  formatted :price, :shipping, with: :number_format

  validates_numericality_of :price, :shipping, only_integer: true

  # Receives a formatted value and converts it into an integer value.
  private def convert_with_number_format(number)
    number = BigDecimal(number.to_s) / 100
    number_to_currency(number, unit: "", separator: ",", delimiter: "")
  end

  # Receives a integer value and converts into a formatted number string.
  private def convert_from_number_format(number)
    _, operator, number, precision =
      *number.to_s.match(/^([+-])?(\d+)(?:[,.](\d+))?$/)

    (BigDecimal("#{operator}#{number}.#{precision.to_i}") * 100).to_i
  end
end

class Post
  attr_accessor :text

  include FormattedAttributes
  formatted_attribute :text, with: :html

  def convert_with_html(text)
    %[<p>#{text}</p>]
  end

  def convert_from_html(text)
    text.to_s[%r{^<p>(.*?)</p>$}, 1]
  end
end

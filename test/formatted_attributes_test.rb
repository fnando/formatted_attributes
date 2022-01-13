# frozen_string_literal: true

require "test_helper"

class FormattedAttributesTest < Minitest::Test
  test "sets initial value" do
    product = Product.new(price: 12_300)

    assert_equal "123,00", product.formatted_price
  end

  test "updates formatted price" do
    product = Product.new(price: 12_300)
    assert_equal "123,00", product.formatted_price

    product.price = 45_600
    assert_equal "456,00", product.formatted_price
  end

  test "sets formatted value" do
    product = Product.new(price: 12_300)
    product.formatted_price = "456,78"

    assert_equal 45_678, product.price
    assert_equal "456,78", product.formatted_price

    product.shipping = 67_800
    product.formatted_shipping = "345,67"

    assert_equal 34_567, product.shipping
    assert_equal "345,67", product.formatted_shipping

    assert product.valid?
  end

  test "works with non-activerecord classes" do
    post = Post.new
    post.text = "hello"

    assert_equal "<p>hello</p>", post.formatted_text

    post.formatted_text = "<p>nice</p>"

    assert_equal "nice", post.text

    post.text = "cool"

    assert_equal "<p>cool</p>", post.formatted_text
  end
end

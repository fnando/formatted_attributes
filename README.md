# formatted_attributes

[![Tests](https://github.com/fnando/formatted_attributes/workflows/ruby-tests/badge.svg)](https://github.com/fnando/formatted_attributes)
[![Gem](https://img.shields.io/gem/v/formatted_attributes.svg)](https://rubygems.org/gems/formatted_attributes)
[![Gem](https://img.shields.io/gem/dt/formatted_attributes.svg)](https://rubygems.org/gems/formatted_attributes)

Add methods that format attributes from/to helper methods. Works with
ActiveRecord and non-ActiveRecord classes.

## Installation

```bash
gem install formatted_attributes
```

Or add the following line to your project's Gemfile:

```ruby
gem "formatted_attributes"
```

## Usage

A formatted attribute will require two methods: `convert_with_#{formatter}` and
`convert_from_#{formatter}`. The `convert_from_*` method will convert the
formatted value to the original value and the `convert_with_*` method will do
the other way around, converting the original value to the formatted version.

See an example on how to format prices from strings like 1,23 to cents like 123
and vice-versa.

```ruby
class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  formatted :price, with: :number_format

  private
  def convert_with_number_format(amount)
    number = BigDecimal(number.to_s) / 100
    number_to_currency(number, unit: "", separator: ",", delimiter: "")
  end

  def convert_from_number_format(amount)
    _, operator, number, precision = *number.to_s.match(/^([+-])?(\d+)(?:[,.](\d+))?$/)
    (BigDecimal("#{operator}#{number}.#{precision.to_i}") * 100).to_i
  end
end

product = Product.new(formatted_price: "1,23")
product.price
#=> 123

product.price = 456
product.formatted_price
#=> "4,56"
```

## Maintainer

- [Nando Vieira](https://github.com/fnando)

## Contributors

- https://github.com/fnando/formatted_attributes/contributors

## Contributing

For more details about how to contribute, please read
https://github.com/fnando/formatted_attributes/blob/main/CONTRIBUTING.md.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT). A copy of the license can be
found at https://github.com/fnando/formatted_attributes/blob/main/LICENSE.md.

## Code of Conduct

Everyone interacting in the formatted_attributes project's codebases, issue
trackers, chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/fnando/formatted_attributes/blob/main/CODE_OF_CONDUCT.md).

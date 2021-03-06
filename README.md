# Formatted Attributes

Sometimes you want to use a proxy attribute that will be formatted while displaying its value or receiving data from user.

## Install

    gem install formatted_attributes

## Usage

A formatted attribute will require two methods: `format_to_#{formatter}` and `format_from_#{formatter}`. The `format_to_*` method will convert the formatted value to the original value and the `format_from_*` method will do the other way around, converting the original value to the formatted version.

See an example on how to format prices from strings like `1,23` to cents like `123` and vice-versa.

```ruby
class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  formatted :price, with: 'cents'

  private
  def format_to_cents(amount)
    _, operator, number, precision = *number.to_s.match(/^([+-])?(\d+)(?:[,.](\d+))?$/)
    (BigDecimal("#{operator}#{number}.#{precision.to_i}") * 100).to_i
  end

  def format_from_cents(amount)
    number = BigDecimal(number.to_s) / 100
    number_to_currency(number, unit: '', separator: ',', delimiter: '')
  end
end

product = Product.new(formatted_price: '1,23')
product.price
#=> 123

product.price = 456
product.formatted_price
#=> "4,56"
```

## Maintainer

* Nando Vieira (http://nandovieira.com.br)

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

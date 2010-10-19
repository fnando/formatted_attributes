require "spec_helper"

describe FormattedAttributes do
  subject { Product.new }

  context "formatted methods" do
    it "should add getters" do
      subject.should respond_to(:formatted_price)
      subject.should respond_to(:formatted_shipping)
    end

    it "should add setters" do
      subject.should respond_to(:formatted_price=)
      subject.should respond_to(:formatted_shipping=)
    end

    it "should set initial value" do
      subject.price = 12300
      subject.formatted_price.should == "123,00"
    end

    it "should update formatted price" do
      subject.price = 12300
      subject.formatted_price.should == "123,00"

      subject.price = 45600
      subject.formatted_price.should == "456,00"
    end

    it "should set formatted value" do
      subject.price = 12300
      subject.formatted_price = "456,78"
      subject.formatted_price.should == "456,78"
      subject.price.should == 45678

      subject.shipping = 67800
      subject.formatted_shipping = "345,67"
      subject.formatted_shipping.should == "345,67"
      subject.shipping.should == 34567

      subject.should be_valid
    end
  end
end

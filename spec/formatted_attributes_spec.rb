require "spec_helper"

describe FormattedAttributes do
  subject { Product.new }

  context "formatted methods" do
    it "should add getters" do
      expect(subject).to respond_to(:formatted_price)
      expect(subject).to respond_to(:formatted_shipping)
    end

    it "should add setters" do
      expect(subject).to respond_to(:formatted_price=)
      expect(subject).to respond_to(:formatted_shipping=)
    end

    it "should set initial value" do
      subject.price = 12300
      expect(subject.formatted_price).to eq("123,00")
    end

    it "should update formatted price" do
      subject.price = 12300
      expect(subject.formatted_price).to eq("123,00")

      subject.price = 45600
      expect(subject.formatted_price).to eq("456,00")
    end

    it "should set formatted value" do
      subject.price = 12300
      subject.formatted_price = "456,78"
      expect(subject.formatted_price).to eq("456,78")
      expect(subject.price).to eq(45678)

      subject.shipping = 67800
      subject.formatted_shipping = "345,67"
      expect(subject.formatted_shipping).to eq("345,67")
      expect(subject.shipping).to eq(34567)

      expect(subject).to be_valid
    end
  end
end

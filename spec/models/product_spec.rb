require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do 
      @category = Category.create(name: "Athletics")
    end
    
    it "saves if all validations are present" do
      product = Product.new(name: "Hockey Stick", quantity: 5, price: 55.55, category: @category)
      expect(product.save).to be true
    end
    
    it "it fails to save if name is not present" do
      product = Product.new(name: nil, quantity: 5, price: 55.55, category: @category)
      expect(product.save).to be false
      expect(product.errors.full_messages).to include(product.errors.full_messages[0])
      p product.errors.full_messages
    end

    it "it fails to save if price is not present" do
      product = Product.new(name: "Hockey Stick", quantity: 5, price: nil, category: @category)
      expect(product.save).to be false
      expect(product.errors.full_messages).to include(product.errors.full_messages[0])
      p product.errors.full_messages
    end

    it "it fails to save if quantity is not present" do
      product = Product.new(name: "Tennis Racket", quantity: nil, price: 55.55, category: @category)
      expect(product.save).to be false
      expect(product.errors.full_messages).to include(product.errors.full_messages[0])
      p product.errors.full_messages
    end

    it "it fails to save if category is not present" do
      product = Product.new(name: "BaseBall", quantity: 5, price: 55.55, category: nil)
      expect(product.save).to be false
      expect(product.errors.full_messages).to include(product.errors.full_messages[0])
      p product.errors.full_messages
    end

  end
end

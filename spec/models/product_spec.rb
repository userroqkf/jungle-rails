require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    describe '#create' do
      it 'should save when it passes all validation' do
        @category = Category.new(name: 'Tree')
        @product = Product.create(name: 'Tree', category: @category, quantity: 1, price: 200)
        expect(@product.errors.full_messages[0]).to eq nil
      end
    end 

    describe 'should raise error when input is not given' do
      it 'should raise error when name is not given' do
        @category = Category.new(name: 'Tree')
        @product = Product.create(name: nil, category: @category, quantity: 1, price: 200)
        expect(@product.errors.full_messages[0]).to eq "Name can't be blank"
      end

      it 'should raise error when price is not a number' do
        @category = Category.new(name: 'Tree')
        @product = Product.create(name: "Tree", category: @category, quantity: 1, price: "")
        expect(@product.errors.full_messages[0]).to eq "Price is not a number"
      end

      it 'should raise error when quantity is not given' do
        @category = Category.new(name: 'Tree')
        @product = Product.create(name: "Tree", category: @category, quantity: nil, price: 200)
        expect(@product.errors.full_messages[0]).to eq "Quantity can't be blank"
      end

      it 'should raise error when category is not given' do
        @product = Product.create(name: "Tree", category: nil, quantity: 1, price: 200)
        expect(@product.errors.full_messages[0]).to eq "Category must exist"
      end
    end
    


  end
end

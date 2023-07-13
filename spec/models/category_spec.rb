require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(name: 'John') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      category = Category.new(name: 'Food', icon: 'food.jpg', user:)
      expect(category).to be_valid
    end

    it 'is invalid without a name' do
      category = Category.new(icon: 'food.jpg', user:)
      expect(category).to be_invalid
      expect(category.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a name shorter than 3 characters' do
      category = Category.new(name: 'AB', icon: 'food.jpg', user:)
      expect(category).to be_invalid
      expect(category.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'is invalid with a name longer than 30 characters' do
      category = Category.new(name: 'A' * 31, icon: 'food.jpg', user:)
      expect(category).to be_invalid
      expect(category.errors[:name]).to include('is too long (maximum is 30 characters)')
    end

    it 'is invalid without an icon' do
      category = Category.new(name: 'Food', user:)
      expect(category).to be_invalid
      expect(category.errors[:icon]).to include("can't be blank")
    end
  end
end

require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create(name: 'John') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expense = Expense.new(name: 'Groceries', amount: 50, user: user)
      expect(expense).to be_valid
    end

    it 'is invalid without a name' do
      expense = Expense.new(amount: 50, user: user)
      expect(expense).to be_invalid
    end

    it 'is invalid with a name shorter than 3 characters' do
      expense = Expense.new(name: 'AB', amount: 50, user: user)
      expect(expense).to be_invalid
    end

    it 'is invalid with a name longer than 30 characters' do
      expense = Expense.new(name: 'A' * 31, amount: 50, user: user)
      expect(expense).to be_invalid
    end

    it 'is invalid without an amount' do
      expense = Expense.new(name: 'Groceries', user: user)
      expect(expense).to be_invalid
    end

    it 'is invalid with a non-positive amount' do
      expense = Expense.new(name: 'Groceries', amount: -10, user: user)
      expect(expense).to be_invalid
    end
  end
end


class Expense < ApplicationRecord
  belongs_to :user, foreign_key: :author_id
  has_many :category_expenses, dependent: :destroy
  has_many :categories, through: :category_expenses, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end

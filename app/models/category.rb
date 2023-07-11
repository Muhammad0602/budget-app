class Category < ApplicationRecord
    belongs_to :user
    has_many :category_expenses
    has_many :expenses, through: :category_expenses

    validates :name, presence: true, length: { minimum: 5, maximum: 30 }
    validates :icon, presence: true
    validates :author_id, presence: true
end

require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  describe 'index page' do
    before(:each) do
      Category.create(name: 'Health', icon: 'health.jpg')
      Category.create(name: 'Food', icon: 'food.jpg')
      Category.create(name: 'Education', icon: 'education.jpg')
      user = User.create(email: 'test@example.com', password: 'password')
      sign_in user
      visit categories_path
    end

    let(:categories) { Category.all }

    it 'shows the right name' do
      categories.each do |category|
        expect(page).to have_content(category.name)
      end
    end

    it 'shows the correct icon' do
      categories.each do |category|
        expect(page).to have_css("img[src*='#{category.icon}']")
      end
    end
  end
end

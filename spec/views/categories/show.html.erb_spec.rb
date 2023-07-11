require 'rails_helper'

RSpec.describe "categories/show", type: :view do
  before(:each) do
    assign(:category, Category.create!(
      author_id: 2,
      name: "Name",
      icon: "Icon"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Icon/)
  end
end

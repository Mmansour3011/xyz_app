require 'rails_helper'

RSpec.describe "users/index", type: :view do
  let(:users) { create_list(:user, 2) }

  before(:each) do
    assign(:users, users)
    render #This line actually renders the view template associated with the controller action being tested
  end

  it "renders a list of users in the user index page" do
    users.each do |user|
      expect(rendered).to have_selector(cell_selector, text: user.title)
      expect(rendered).to have_selector(cell_selector, text: user.content)
    end
  end

  def cell_selector
    'div>p' 
  end
end
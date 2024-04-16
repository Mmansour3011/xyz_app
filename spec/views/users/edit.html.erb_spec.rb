require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  
  let(:user) {
    create(:user)
  }

  before(:each) do
    assign(:user, user)
    render
  end

  it "renders the edit user form" do
    expect(rendered).to have_selector("form[action='#{user_path(user)}'][method='post']") do  
    expect(rendered).to have_selector("input[name='user[title]']")
    expect(rendered).to have_selector("textarea[name='user[content]']")
    end
  end
end

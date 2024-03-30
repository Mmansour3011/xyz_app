require 'rails_helper'

RSpec.describe "users/new", type: :view do

  let(:user) {build(:user)}
    before(:each) do 
      assign(:user,user)
      render
    end

  it "renders new user form" do
      expect(rendered).to have_selector("form[action='#{users_path}'][method='post']") do
      expect(rendered).to have_selector("input[name='user[title]']")
      expect(rendered).to have_selector("textarea[name='user[content]']")
    end

  end
  
end

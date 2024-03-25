require 'rails_helper'

RSpec.describe "todos/new", type: :view do

  let(:todo) {build(:todo)}
    before(:each) do 
      assign(:todo,todo)
      render
    end

  it "renders new todo form" do
      expect(rendered).to have_selector("form[action='#{todos_path}'][method='post']") do
      expect(rendered).to have_selector("input[name='todo[title]']")
      expect(rendered).to have_selector("textarea[name='todo[content]']")
    end

  end
  
end

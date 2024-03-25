require 'rails_helper'

RSpec.describe "todos/edit", type: :view do
  
  let(:todo) {
    create(:todo)
  }

  before(:each) do
    assign(:todo, todo)
    render
  end

  it "renders the edit todo form" do
    expect(rendered).to have_selector("form[action='#{todo_path(todo)}'][method='post']") do  
    expect(rendered).to have_selector("input[name='todo[title]']")
    expect(rendered).to have_selector("textarea[name='todo[content]']")
    end
  end
end

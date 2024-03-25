require 'rails_helper'

RSpec.describe "todos/index", type: :view do
  let(:todos) { create_list(:todo, 2) }

  before(:each) do
    assign(:todos, todos)
    render #This line actually renders the view template associated with the controller action being tested
  end

  it "renders a list of todos in the todo index page" do
    todos.each do |todo|
      expect(rendered).to have_selector(cell_selector, text: todo.title)
      expect(rendered).to have_selector(cell_selector, text: todo.content)
    end
  end

  def cell_selector
    'div>p' 
  end
end
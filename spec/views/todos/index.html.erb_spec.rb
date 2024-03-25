require 'rails_helper'

RSpec.describe "todos/index", type: :view do
  
  before(:each) do
    assign(:todos, [
      todo1=create(:todo),
      todo2=create(:todo)
    ])
  end

  it "renders a list of todos in the todo index page" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
  end
end

require 'rails_helper'

RSpec.describe "todos/show", type: :view do
  let(:todo) {create(:todo)}
  before(:each) do
    assign(:todo, todo)
  end

  it "renders attributes in <p>" do
    render 
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
  
end

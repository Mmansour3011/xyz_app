require 'rails_helper'

RSpec.describe Todo, type: :model do

  it "every todo should have unique id" do
    todo1=create(:todo)
    todo2=create(:todo)
    expect(todo1.id).not_to be eq(todo2.id)
  end

  it "is not valid with title longer than 100 characters" do 
    todo=build(:todo , title: "a" * 101)
    expect(todo).not_to be_valid
    expect(todo.errors[:title]).to include("maximum is 100 characters")
  end 

  it "is valid withoud a content" do
    todo=build(:todo,content: nil)
    expect(todo).to be_valid
  end
  
end
require 'rails_helper'

RSpec.describe Todo, type: :model do
  subject(:user) { create(:user) }

  context "create todo" do
    it "should have unique id" do
      todo1=user.todos.create(title: "todo1")
      todo2=user.todos.create(title: "todo2")
      expect(todo1.id).not_to be eq(todo2.id)
    end
    
    it "is not valid with title longer than 100 characters" do 
      todo=user.todos.create(title: "a" * 101)
      expect(todo).not_to be_valid
      expect(todo.errors[:title]).to include("maximum is 100 characters")
    end 
    
    it "is valid withoud a content" do
      todo=user.todos.create(title: "test",content: nil)
      expect(todo).to be_valid
    end

  end

  context "todo shares" do
    let(:user2) { create(:user, name: "user2",email: "test2@test.com") }
    let(:user3) { create(:user, name: "user3",email: "test3@test.com") }

    it "can be done to a single user" do
      todo=user.todos.create(title: "test")
      todo.share_with(user2)
      expect(user2.shared_todos).to include(todo)
    end
    it "can be done to multiple users" do
      todo=user.todos.create(title: "test")
      todo.share_with([user2,user3])
      expect(user2.shared_todos).to include(todo)
      expect(user3.shared_todos).to include(todo)
    end
    it "is removed when todo is deleted"do
    todo=user.todos.create(title: "test")
    todo.share_with(user2)
    todo.destroy
    expect(user2.shared_todos).to_not include(todo)
    end
  end


 
  
end
require 'rails_helper'

RSpec.describe "/todos", type: :request do
  
  let(:valid_attributes) {
    attributes_for(:todo)  
  }

  let(:invalid_attributes) {
    attributes_for(:todo, title: nil)  
  }

  context "index todo" do
  
    it "Shows all todos when going to index page" do
      todo=build(:todo)
      get todos_url
      expect(response).to be_successful
    end

  end

  context "show todo" do

    it "Shows needed todo when going to show page" do
      todo=create(:todo)
      get todo_url(todo)
      expect(response).to be_successful
    end

  end

  context "create todo" do

    it "goes to create todo when going to create page" do
      get new_todo_url
      expect(response).to be_successful
    end

    it "creates a new Todo successfully when creating it with valid parameters" do
      expect {
        post todos_url, params: {todo: valid_attributes}
      }.to change(Todo, :count).by(1)
    end

    it "redirects to the created todo" do
      post todos_url, params: { todo: valid_attributes}
      expect(response).to redirect_to(todo_url(Todo.last))
    end

    it "does not create a new Todo with empty title" do
      expect {
        post todos_url, params: { todo: invalid_attributes }
      }.to change(Todo, :count).by(0)
    end

    it "renders a response with 422 status (i.e. to display the 'new' template)" do
      post todos_url, params: { todo: invalid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  
  end

  context "edit todo" do
    it "goes to edit todo when going to edit page" do
      todo=create(:todo)
      get edit_todo_url(todo)
      expect(response).to be_successful
    end

    it "updates the requested todo successfully" do
      todo = create(:todo,title: "todo1")
      patch todo_url(todo), params: { todo: {title: "todo2"} }
      todo.reload
      expect(todo.title).to eq("todo2")
    end

    it "redirects to the todo page when updating attributes" do
      todo = create(:todo,title: "todo1")
      patch todo_url(todo), params: { todo: {title: "todo2"} }
      todo.reload
      expect(response).to redirect_to(todo_url(todo))
    end
  
    it "renders a response with 422 status (i.e. to display the 'edit' template when updating with empty title)" do
      todo = create(:todo,title: "todo1")
      patch todo_url(todo), params: { todo: {title: nil}}
      expect(response).to have_http_status(:unprocessable_entity)
    end
    
  end
    
      context "delete todo" do
        it "destroys the requested todo when clicking delete" do
          todo = create(:todo,title: "todo1")
          expect {
            delete todo_url(todo)
          }.to change(Todo, :count).by(-1)
        end
    
        it "redirects to the todos list when deleting todo" do
          todo = create(:todo,title: "todo1")
          delete todo_url(todo)
          expect(response).to redirect_to(todos_url)
        end
      end
   
  end
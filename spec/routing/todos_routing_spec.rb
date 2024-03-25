require "rails_helper"

RSpec.describe TodosController, type: :routing do

  describe "routing" do

    it "routes to index_todos" do
      expect(get: "/todos").to route_to("todos#index")
    end

    it "routes to new_todo" do
      expect(get: "/todos/new").to route_to("todos#new")
    end

    it "routes to show_todo" do
      todo=create(:todo)
      expect(get: "/todos/#{todo.id}").to route_to("todos#show", id: "#{todo.id}")
    end

    it "routes to edit_todo" do
    todo=create(:todo)
      expect(get: "/todos/#{todo.id}/edit").to route_to("todos#edit", id: "#{todo.id}")
    end


    it "routes to create_todo" do
      expect(post: "/todos").to route_to("todos#create")
    end

    it "routes to update_todo via PUT" do
      todo=create(:todo)
      expect(put: "/todos/#{todo.id}").to route_to("todos#update", id: "#{todo.id}")
    end

    it "routes to update_todo via PATCH" do
    todo=create(:todo)
      expect(patch: "/todos/#{todo.id}").to route_to("todos#update", id: "#{todo.id}")
    end

    it "routes to destroy_todo" do
    todo=create(:todo)
      expect(delete: "/todos/#{todo.id}").to route_to("todos#destroy", id: "#{todo.id}")
    end

  end
  
end
require "rails_helper"

RSpec.describe UsersController, type: :routing do
    describe "routing" do

        it "routes to index_users" do
          expect(get: "/users").to route_to("users#index")
        end
    
        it "routes to new_user" do
          expect(get: "/users/new").to route_to("users#new")
        end
    
        it "routes to show_user" do
          user=create(:user)
          expect(get: "/users/#{user.id}").to route_to("users#show", id: "#{user.id}")
        end
    
        it "routes to edit_user" do
        user=create(:user)
          expect(get: "/users/#{user.id}/edit").to route_to("users#edit", id: "#{user.id}")
        end
    
    
        it "routes to create_user" do
          expect(post: "/users").to route_to("users#create")
        end
    
        it "routes to update_user via PUT" do
          user=create(:user)
          expect(put: "/users/#{user.id}").to route_to("users#update", id: "#{user.id}")
        end
    
        it "routes to update_user via PATCH" do
        user=create(:user)
          expect(patch: "/users/#{user.id}").to route_to("users#update", id: "#{user.id}")
        end
    
        it "routes to destroy_user" do
        user=create(:user)
          expect(delete: "/users/#{user.id}").to route_to("users#destroy", id: "#{user.id}")
        end
    
      end

end
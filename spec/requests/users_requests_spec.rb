require "rails_helper"

RSpec.describe "/users", type: :request do
    let(:valid_attributes){
        attributes_for(:user)
    }

    let(:invalid_attributes){
        attributes_for(:user,name:nil)
    }

    content "index user" do

        it "Shows all users when going to index page" do
            user=build(:user)
            get users_url
            expect(response).to be_successful
          end
    end

    context "show user" do

        it "Shows needed user when going to show page" do
          user=create(:user)
          get user_url(user)
          expect(response).to be_successful
        end
    
      end

      context "create user" do

        it "goes to create user when going to create page" do
          get new_user_url
          expect(response).to be_successful
        end
    
        it "creates a new user successfully when creating it with valid parameters" do
          expect {
            post users_url, params: {user: valid_attributes}
          }.to change(User, :count).by(1)
        end
    
        it "redirects to the created user" do
          post users_url, params: { user: valid_attributes}
          expect(response).to redirect_to(user_url(User.last))
        end
    
        it "does not create a new user with empty title" do
          expect {
            post users_url, params: { user: invalid_attributes }
          }.to change(User, :count).by(0)
        end
    
        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post users_url, params: { user: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      
      end


      context "edit user" do
        it "goes to edit user when going to edit page" do
          user=create(:user)
          get edit_user_url(user)
          expect(response).to be_successful
        end
    
        it "updates the requested user successfully" do
          user = create(:user,title: "user1")
          patch user_url(user), params: { user: {title: "user2"} }
          user.reload
          expect(user.title).to eq("user2")
        end
    
        it "redirects to the user page when updating attributes" do
          user = create(:user,title: "user1")
          patch user_url(user), params: { user: {title: "user2"} }
          user.reload
          expect(response).to redirect_to(user_url(user))
        end
      
        it "renders a response with 422 status (i.e. to display the 'edit' template when updating with empty title)" do
          user = create(:user,title: "user1")
          patch user_url(user), params: { user: {title: nil}}
          expect(response).to have_http_status(:unprocessable_entity)
        end
        
      end



      context "delete user" do
        it "destroys the requested user when clicking delete" do
          user = create(:user,title: "user1")
          expect {
            delete user_url(user)
          }.to change(User, :count).by(-1)
        end
    
        it "redirects to the users list when deleting user" do
          user = create(:user,title: "user1")
          delete user_url(user)
          expect(response).to redirect_to(user_url)
        end
      end




end
require 'rails_helper'

RSpec.describe "Sessions", type: :request do
      let(:user) { FactoryBot.create(:user) }
      let(:valid_credentials) { { email: user.email, password: user.password } }
  
    context "User login " do
      it "logs in the user with valid credentials" do
        post "/login", params: { session: valid_credentials }
        expect(response).to redirect_to(todos_path)
        expect(session[:user_id]).to eq(user.id)
      end
  
      it "rejects invalid credentials" do
        post "/login", params: { session: { email: "invalid@example.com", password: "invalid" } }
        expect(session[:user_id]).to be_nil
      end
    end


    context "User logout " do
        it "logs out the user" do
            delete "/logout"
            expect(response).to redirect_to(root_path)
            expect(session[:user_id]).to be_nil
          end
    end


  end
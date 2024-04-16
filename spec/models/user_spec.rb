require 'rails_helper'

RSpec.describe User, type: :model do
    it 'is valid with valid attributes' do
        user = build(:user)
        expect(user).to be_valid
        end

    it "user should have unique id" do
        user=build(:user)
        user1=create(:user,email:"user1@xyz.com")
        user2=create(:user,email:"user2@xyz.com")
        expect(user1.id).not_to eq(user2.id)
        end

    context "user name validation" do
        it "Name can't be empty" do 
            user=build(:user,name: nil)
            expect(user).not_to be_valid
            end

        it "Name doesn't exceed 50 letters" do 
            user=build(:user,name: "a"*51)
            expect(user).not_to be_valid
            end
    end

    context "user email validation" do
        it "Email can't be empty" do 
            user=build(:user,email: nil)
            expect(user).not_to be_valid
            end

        it "Email should be unique" do
            user1=create(:user,email: "test@test.com")
            user2=build(:user,email: "test@test.com")
            expect(user2).not_to be_valid
            end

        it "Email should follow a regex" do
            user1=build(:user,email: "test.com")
            user2=build(:user,email: "test")
            user3=build(:user,email: "test@test.com")
            expect(user1).not_to be_valid
            expect(user2).not_to be_valid
            expect(user3).to be_valid
            end

        it "Email should be case insensitive" do 
            user1=create(:user,email: "test@test.com")
            user2=build(:user,email: "Test@test.com")
            expect(user2).not_to be_valid
            end

    end

    context "user password validation" do
        it "Password can't be empty" do 
            user=build(:user,password: nil)
            expect(user).not_to be_valid
            end

        it "Password can't be less than 6 letters" do 
            user=build(:user,password: "a"*5)
            expect(user).not_to be_valid
            end

        it "password is encrypted before saving" do
            user=build(:user,password: "password")
            expect(user.password_digest).not_to eq("password")
            end

        it "password and password_confirmation and identical" do 
            user=build(:user,password: "123456", password_confirmation: "111")
            expect(user).not_to be_valid
        end

        it "password_confirmation is encrypted before saving" do
            user=build(:user,password: "password", password_confirmation: "password")
            expect(user.password_digest).not_to eq("password")
        end
    end
    context "user soft delete"do
        it "When user is deleted , it's soft deleted successully"do
        user=create(:user)
        user.archive
        expect(user.soft_delete).to eq(true)
        end
        
        it "user cant be created with a deleted user email"do
        user1=create(:user,email: "test@test.com")
        user1.archive
        user2.create(:user,email: "test@test.com")
        expect(user2).not_to be_valid
        end
    end

    context "admin users" do
    end





end
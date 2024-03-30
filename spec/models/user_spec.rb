require "rails_helper"

RSpec.describe User, type: :model do
    it 'is valid with valid attributes' do
        user = build(:user)
        expect(user).to be_valid
        end

    it "user should have unique id" do
        user=build(:user)
        user1=create(:user)
        user2=create(:user)
        expect(user1.id).not_to eq(user2.id)
        end

    content "user name validation" do
        it "Name can't be empty" do 
            user=build(:user,name: nil)
            expect(user).not_to be_valid
            end

        it "Name doesn't exceed 50 letters" do 
            user=build(:user,name: "a"*51)
            expect(user).not_to be_valid
            end
    end

    content "user email validation" do
        it "Email can't be empty" do 
            user=build(:user,email: nil)
            expect(user).not_to be_valid
            end

        it "Email should be unique" do
            user1=create(:user,email: "test@test.com")
            user2=create(:user,email: "test@test.com")
            expect(user2).not_to be_valid
            end

        it "Email should follow a regex" do
            user1=create(:user,email: "test.com")
            user2=create(:user,email: "test")
            user3=create(:user,email: "test@test")
            user4=create(:user,email: "test@test.com")
            expect(user1).not_to be_valid
            expect(user2).not_to be_valid
            expect(user3).not_to be_valid
            expect(user4).to be_valid
            end

        it "Email should be case insensitive" do 
            user1=create(:user,email: "test@test.com")
            user2=create(:user,email: "Test@test.com")
            expect(user2).not_to be_valid
            end

    end

    content "user password validation" do
        it "Password can't be empty" do 
            user=build(:user,password: nil)
            expect(user).not_to be_valid
            end

        it "Password can't be less than 6 letters" do 
            user=build(:user,password: "a"*5)
            expect(user).not_to be_valid
            end

        it "password is encrypted before saving" do
            user=build(":user",password: password)
            expect(user.password_digest).not_to eq(password)
            end

    end

    content "user soft delete"do
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





end
require 'rails_helper'

RSpec.describe User, type: :model do
    subject(:user) { build(:user) }

    context "user validations" do
    it 'expects user to be valid' do
        expect(user).to be_valid
        end

    it "requires unique id" do
        user1=create(:user,email:"user1@xyz.com")
        user2=create(:user,email:"user2@xyz.com")
        expect(user1.id).not_to eq(user2.id)
        end
    end

    context "name" do
        it "can't be empty" do 
            user.name=nil
            expect(user).not_to be_valid
            end

        it "doesn't exceed 50 letters" do 
            user.name="a"*51
            expect(user).not_to be_valid
            end
    end

    context "email" do
        it "can't be empty" do 
            user.email=nil
            expect(user).not_to be_valid
            end

        it "must be unique" do
            user1=create(:user,email: "test@test.com")
            user2=build(:user,email: "test@test.com")
            expect(user2).not_to be_valid
            end

        it "must follow a regex" do
            user.email = 'test.com'
            expect(user).not_to be_valid
    
            user.email = 'test'
            expect(user).not_to be_valid
    
            user.email = 'test@test.com'
            expect(user).to be_valid
            end

        it "is case insensitive" do 
            create(:user, email: 'test@test.com')
            user.email = 'Test@test.com'
            expect(user).not_to be_valid
            end

    end

    context "password" do
        it "can't be empty" do 
            user.password=nil
            expect(user).not_to be_valid
            end

        it "can't be less than 6 letters" do 
            user.password="a"*5
            expect(user).not_to be_valid
            end

        it "is encrypted before saving" do
            user.password="password"
            expect(user.password_digest).not_to eq("password")
            end

        it "requires password confirmation" do 
            user.password = '123456'
            user.password_confirmation = '111'
            expect(user).not_to be_valid
        end

        it "encrypts password_confirmation before saving" do
            user.password="password"
            user.password_confirmation="password"
            expect(user.password_digest).not_to eq("password")
        end
    end
    context "soft delete" do
        it 'successfully soft deletes user' do
        user=create(:user)
        user.archive
        expect(user.soft_delete).to eq(true)
        end
        
        it "doesn't allow creation of user with deleted user email" do
        user1=create(:user,email: "test@test.com")
        user1.archive
        expect {create(:user,email: "test@test.com")}.to raise_error
        end
    end

    context "admin" do
        let (:admin) {create(:user,admin: true)}
        let (:user1) {create(:user,email: "user1@test.com")}
        let (:user2) {create(:user,email: "user2@test.com")}
        let (:user3) {create(:user,email: "user3@test.com")}
        it "only can access all users" do
            current_user=admin
            expect { User.find(user1.id) }.to_not raise_error
            expect { User.find(user2.id) }.to_not raise_error
            expect { User.find(user3.id) }.to_not raise_error
        end
        
        it 'can update other users' do
            new_name = 'Updated Name'
            user1_name_before_update = user1.name
            user1.update(name: new_name)
            expect(user1.reload.name).to eq(new_name)
            user1.update(name: user1_name_before_update)
        end

        it 'can delete other users' do
            user1.archive
            expect(user1.soft_delete).to eq(true)
        end

        it "only can access all users" do  
            todo1=user1.todos.create(title: "test")
            todo2=user2.todos.create(title: "test")
            todo3=user3.todos.create(title: "test")
        
            expect {admin.todos.where(id: todo1.id)}.to_not raise_error
            expect {todo1.update(title: "Updated title by admin")}.to_not raise_error
            expect {todo1.destroy}.to_not raise_error
                 
            expect {admin.todos.where(id: todo2.id)}.to_not raise_error
            expect {todo2.update(title: "Updated title by admin")}.to_not raise_error
            expect {todo2.destroy}.to_not raise_error
        end
    end

    context "todos" do
        let(:user1) { create(:user) }
        let(:user2) { build(:user, email: 'Test@test.com') }

        it "are created only when related to its user"do
        todo1=user1.todos.create(title: "user1")

        expect(user1.todos.count).to eq(1)
        expect(todo1.user).to eq(user1)

        expect {todo1.update(title: "Updated title")}.to_not raise_error      
        expect {todo1.destroy}.to_not raise_error
        end

        it "are accessed only by its owner" do
        todo1=user1.todos.create(title: "user1")

        expect(user1.todos.count).to eq(1)
        expect(user2.todos.count).to eq(0)
        expect(todo1.user).to eq(user1)

        expect {user2.todos.find(todo1.id)}.to raise_error(ActiveRecord::RecordNotFound)
        expect {user2.todos.find(todo1.id).update(title: "Updated title by user 2")}.to raise_error(ActiveRecord::RecordNotFound)
        expect {user2.todos.find(todo1.id).destroy}.to raise_error(ActiveRecord::RecordNotFound)
        end

     

    end




end
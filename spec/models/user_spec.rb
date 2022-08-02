require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation' do
    context 'it must be created wtth password and password_confirmation fields' do
      it 'should return true if password and password_confirmation are the same' do
        @User = User.create({
          :name => "User Test",
          :email => "Test@test.com",
          :password => "testpassword",
          :password_confirmation => "testpassword"
          })
          expect(@User).to be_valid
      end

      it 'should return fail if password and password_confirmation are not the same' do
        @User = User.create({
          :name => "User Test",
          :email => "Test@test.com",
          :password => "testpassword",
          :password_confirmation => "wrongpassword"
          })
        expect(@User).not_to be_valid
      end

      it 'should have both password and password_confirmation' do 
        @User = User.create({
          :name => "User Test",
          :email => "Test@test.com",
          :password => "wrongpassword",
          :password_confirmation => "wrongpassword"
          })

        expect(@User).to be_valid
      end
    end

    context 'it should have an unquie email address' do
      it 'should not case sensitive; for example, TEST@TEST.com should 
      not be allowed if test@test.COM is in the database' do
      @user1 = User.new(name: "Rachel",email: "test@test.com",password:"test",password_confirmation: "test")
      @user2 = User.new(name: "Tachel",email: "Test@Test.com",password:"test",password_confirmation: "test")
      @user1.save
      @user2.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")

      end
    end

    describe 'email and name validation' do 
      it 'should validate email and name to not be empty string' do
        @user1 = User.new(name: nil, email: "test@test.com",password:"test",password_confirmation: "test")
        @user2 = User.new(name: "Test Name", email: nil,password:"test",password_confirmation: "test")
        @user1.save
        @user2.save
        expect(@user1.errors.full_messages).to include("Name can't be blank")
        expect(@user2.errors.full_messages).to include("Email can't be blank")
      end
    end
  
  describe 'password validation' do
    it 'should have minimum length of 3' do 
      @user1 = User.new(name: "test", email: "test@test.com",password:"1",password_confirmation: "1")
      @user1.save
      expect(@user1.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return an instance of the user if successfully authenticated' do
      @user1 = User.create(name: "test", email: "test@test123123.com",password:"testing123",password_confirmation: "testing123")
      auth = User.authenticate_with_credentials('test@test123123.com', 'testing123')
      expect(auth).to match(@user1) 
    end

    it 'should return nil if the user is not found' do
      @user1 = User.create(name: "test", email: "test@test123123.com",password:"testing123",password_confirmation: "testing123")
      auth = User.authenticate_with_credentials('test@test123123.com', 'testing133')
      expect(auth).not_to match(@user1) 
    end
  end
    it 'should authenticate user even if there are trailing spaces on both sides' do 
      @user1 = User.create(name: "test", email: "test@test123123.com",password:"testing123",password_confirmation: "testing123") 
      auth = User.authenticate_with_credentials('  test@test123123.com  ', 'testing123') 
      expect(auth).to match(@user1) 
    end
  end
end

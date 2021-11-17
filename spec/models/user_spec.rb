require 'rails_helper'
require 'user.rb'

RSpec.describe User, type: :model do
  describe "Validations" do

    it 'saves if all validations pass and fields are present' do
      user = User.new(first_name: "Eren", last_name: "Jaeger", email: "eren@gmail.com", password: "12345", password_confirmation: "12345" )
      user.save
      expect(User.find_by_email("eren@gmail.com").first_name).to eq("Eren")
    end

    it 'does not save if password field is blank' do
      user = User.new(first_name: "Joe", last_name: "Dirt", email: "dirt@gmail.com", password: nil, password_confirmation: "123" )
      expect(user.save).to be false
      expect(User.find_by_email("dirt@gmail.com")).to eq(nil)
    end

    it 'does not save if password confirmation field is blank' do
      user = User.new(first_name: "Erwin", last_name: "Smith", email: "erwin@gmail.com", password: "onward", password_confirmation: nil )
      expect(user.save).to be false
      expect(User.find_by_email("erwin@gmail.com")).to eq(nil)
    end

    it 'does not save if password confirmation field does not match password' do
      user = User.new(first_name: "Marcus", last_name: "Naslund", email: "nazzy@gmail.com", password: "number19", password_confirmation: "number99" )
      expect(user.save).to be false
      expect(User.find_by_email("nazzy@gmail.com")).to eq(nil)
    end

    it 'does not save if email is not unique (case_sensitive) in db' do
      user = User.new(first_name: "Eren", last_name: "Jaeger", email: "eren@gmail.com", password: "1234567", password_confirmation: "1234567" )
      expect(user.save).to be true
      user_two = User.new(first_name: "Marcus", last_name: "Naslund", email: "EREN@gmail.com", password: "number19", password_confirmation: "number19" )
      expect(user_two.save).to be false
      expect(User.find_by_email("EREN@gmail.com")).to eq(nil)
    end

    it 'does not save if email is not unique in db' do
      user = User.new(first_name: "Eren", last_name: "Jaeger", email: "eren@gmail.com", password: "1234567", password_confirmation: "1234567" )
      expect(user.save).to be true
      user_two = User.new(first_name: "Marcus", last_name: "Naslund", email: "eren@gmail.com", password: "number19", password_confirmation: "number19" )
      expect(user_two.save).to be false
      expect(User.find_by_first_name("Marcus")).to eq(nil)
    end

    it 'does not save if email field is blank' do
      user = User.new(first_name: "Pavel", last_name: "Bure", email: nil, password: "rocket", password_confirmation: "rocket" )
      expect(user.save).to be false
      expect(User.find_by_first_name("Bure")).to eq(nil)
    end

    it 'does not save if first_name field is blank' do
      user = User.new(first_name: nil, last_name: "Alderson", email: "elliot@gmail.com", password: "qwerty", password_confirmation: "qwerty" )
      expect(user.save).to be false
      expect(User.find_by_email("elliot@gmail.com")).to eq(nil)
    end

    it 'does not save if last_name field is blank' do
      user = User.new(first_name: "Alex", last_name: nil, email: "ovi@gmail.com", password: "gr8", password_confirmation: "gr8" )
      expect(user.save).to be false
      expect(User.find_by_email("ovi@gmail.com")).to eq(nil)
    end

    it 'does not save if password is less than 5 characters' do
      user = User.new(first_name: "Aman", last_name: "Hundal", email: "aman@gmail.com", password: "dune", password_confirmation: "dune" )
      expect(user.save).to be false
      expect(User.find_by_email("aman@gmail.com")).to eq(nil)
    end
  end

  describe '.authenticate_with_credentials' do
    it 'logs you in if password and email exist in DB' do
      user = User.new(first_name: "Pavel", last_name: "Bure", email: 'bure@gmail.com', password: "rocket", password_confirmation: "rocket" )
      expect(user.save).to be true
      auth_user = User.authenticate_with_credentials("bure@gmail.com", "rocket")
      expect(auth_user.first_name).to eq("Pavel")
    end

    it 'creates a nil auth_user if credentials are incorrect' do
      user = User.new(first_name: "Pavel", last_name: "Bure", email: 'bure@gmail.com', password: "rocket", password_confirmation: "rocket" )
      expect(user.save).to be true
      auth_user = User.authenticate_with_credentials("bure@gmail.com", "notrocket")
      expect(auth_user).to eq(nil)
    end

    it 'logs in user even if spaces exist before or after email' do
      user = User.new(first_name: "Pavel", last_name: "Bure", email: 'bure@gmail.com', password: "rocket", password_confirmation: "rocket" )
      expect(user.save).to be true
      auth_user = User.authenticate_with_credentials("  bure@gmail.com   ", "rocket")
      expect(auth_user).to_not eq(nil)
      expect(auth_user.email).to eq("bure@gmail.com")
    end

    it 'logs in user even if email contains capitals and lower case mix' do
      user = User.new(first_name: "Pavel", last_name: "Bure", email: 'bure@gmail.com', password: "rocket", password_confirmation: "rocket" )
      expect(user.save).to be true
      auth_user = User.authenticate_with_credentials("BurE@gmail.com", "rocket")
      expect(auth_user).to_not eq(nil)
      expect(auth_user.email).to eq("bure@gmail.com")
    end

  end

end

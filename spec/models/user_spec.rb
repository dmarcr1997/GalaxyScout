require 'rails_helper'
RSpec.describe User, type: :model do
    it 'has a password field' do
      expect(User.new).to respond_to(:password)
    end
  
    it 'has a username field' do
      expect(User.new).to respond_to(:username)
    end

    it 'has albums' do
      new_user = User.create(username: 'Joe', password_digest: "myJoe")
      new_alb = Album.create(
        title: "You Won't Believe These True Facts",
        date: "2020-01-11",
        center: "Johson",
        creator: "Neil",
        description: "Lorem ipsum",
        nasa_id: '223C',
        href: "http://example.com/here")
      new_user.albums << new_alb
      expect(new_user.albums).to include(new_alb)
    end

    describe 'authenticate' do
        it 'returns the user if credentials match' do
          user = User.new
          user.password = 'foo'
          expect(user.authenticate('foo')).to eq(user)
        end
    
        it "returns falsey if credentials don't match" do
          user = User.new
          user.password = 'foo'
          expect(user.authenticate('fo0')).to be_falsey 
        end
    end
end
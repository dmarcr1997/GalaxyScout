require 'rails_helper'

RSpec.describe Album, type: :model do
    
  let(:valid_attrs) do
    {
      title: "You Won't Believe These True Facts",
      date: "2020-01-11",
      center: "Johson",
      creator: "Neil",
      description: "Lorem ipsum",
      nasa_id: '223C',
      href: "http://example.com/here"
    }
  end

  let(:valid_user) { User.create(username:"Joe", password:"myCupOJoe") }

  let(:valid_album) { Album.new(valid_attrs) }
  let(:missing_title) { Album.new(valid_attrs.except(:title)) }
  let(:missing_date) { Album.new(valid_attrs.except(:date)) }
  let(:missing_description) { Album.new(valid_attrs.except(:description)) }
  let(:missing_href) { Album.new(valid_attrs.except(:href)) }
  
  it "is valid" do
    valid_user.albums << valid_album
    expect(valid_album).to be_valid
  end

  it "is invalid without a title" do
    valid_user.albums << missing_title
    expect(missing_title).to be_invalid
  end

  it "is invalid without a date" do
    valid_user.albums << missing_date
    expect(missing_date).to be_invalid
  end
  
  it "is invalid without a description" do
    valid_user.albums << missing_description
    expect(missing_description).to be_invalid
  end
  
  it "is invalid without a href" do
    valid_user.albums << missing_href
    expect(missing_href).to be_invalid
  end
  
  describe 'ownership' do

    it 'has galaxies' do 
      new_gal = Galaxy.create(
        name: "Andromeda",
        picture_src: "http://picture",
        bio: "This is a galaxy",
        size:"huge")
      valid_album.galaxies << new_gal
      expect(valid_album.galaxies).to include(new_gal)
    end

    it 'has solar systems' do 
      new_sol = SolarSystem.create(
        name: "Home",
        picture_src: "http://picture",
        bio: "This is a solar system")
      valid_album.solar_systems << new_sol
      expect(valid_album.solar_systems).to include(new_sol)
    end

    it 'has planets' do 
      new_planet = Planet.create(
        name: "Mars",
        picture_src: "http://picture",
        bio: "This is Mars",
        size:"medium")
      valid_album.planets << new_planet
      expect(valid_album.planets).to include(new_planet)
    end


  end

end

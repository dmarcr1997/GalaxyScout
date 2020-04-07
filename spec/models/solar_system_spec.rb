require 'rails_helper'

RSpec.describe SolarSystem, type: :model do
  
  let(:galaxy){Galaxy.new(name: "Milky Way",
  picture_src: "http://picture",
  bio: "This is a galaxy", 
  size:"huge")}

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

  let(:valid_album) { Album.new(valid_attrs) }
 
  
  
  it "is valid" do
    new_solar_system = SolarSystem.new(name: "Home", picture_src: "http://picturesrc", bio: "some bio and then some more bio")
    galaxy.solar_systems << new_solar_system
    valid_album.solar_systems << new_solar_system
    expect(new_solar_system).to be_valid
  end

  it "is invalid with no name" do
    new_solar_system = SolarSystem.new( picture_src: "http://picturesrc", bio: "some bio and then some more bio")
    galaxy.solar_systems << new_solar_system
    valid_album.solar_systems << new_solar_system
    expect(new_solar_system).to be_invalid
  end

  it "is invalid with no picture" do
    new_solar_system = SolarSystem.new(name: "Home", bio: "some bio and then some more bio")
    galaxy.solar_systems << new_solar_system
    valid_album.solar_systems << new_solar_system
    
    expect(new_solar_system).to be_invalid
  end

  it "is invalid when non-unique" do
    SolarSystem.create(name: "Home", picture_src: "http://picturesrc", bio: "some bio and then some more bio")
    solar_system = SolarSystem.new(name: "Home", picture_src: "http://picturesrc", bio: "some bio and then some more bio")
    expect(solar_system).to be_invalid
  end
end
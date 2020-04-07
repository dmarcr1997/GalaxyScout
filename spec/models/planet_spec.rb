require 'rails_helper'

RSpec.describe Planet, type: :model do
  let(:solar_system){SolarSystem.new(name: "Home",
  picture_src: "http://picture",
  bio: "This is a solar system")}

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
    planet = Planet.new(name: "Mars", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: 'half million miles')
    valid_album.planets << planet
    solar_system.planets << planet
    expect(planet).to be_valid
  end

  it "is invalid with no name" do
    planet = Planet.new( picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: 'half million miles')
    valid_album.planets << planet
    solar_system.planets << planet
    expect(planet).to be_invalid
  end

  it "is invalid with no picture" do
    planet = Planet.new(name: "Mars", bio: "some bio and then some more bio", size: 'half million miles')
    valid_album.planets << planet
    solar_system.planets << planet
    expect(planet).to be_invalid
  end

  it "is invalid when non-unique" do
    Planet.create(name: "Mars", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: 'half million miles')
    planet = Planet.new(name: "Mars", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: 'half million miles')
    expect(planet).to be_invalid
  end
end

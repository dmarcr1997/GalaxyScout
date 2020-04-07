require 'rails_helper'

RSpec.describe SolarSystem, type: :model do
  it "is valid" do
    solar_system = SolarSystem.new(name: "Home", picture_src: "http://picturesrc", bio: "some bio and then some more bio")
    expect(solar_system).to be_valid
  end

  it "is invalid with no name" do
    solar_system = SolarSystem.new( picture_src: "http://picturesrc", bio: "some bio and then some more bio")
    expect(solar_system).to be_invalid
  end

  it "is invalid with no picture" do
    solar_system = SolarSystem.new(name: "Home", bio: "some bio and then some more bio")
    expect(solar_system).to be_invalid
  end

  it "is invalid when non-unique" do
    SolarSystem.create(name: "Home", picture_src: "http://picturesrc", bio: "some bio and then some more bio")
    solar_system = SolarSystem.new(name: "Home", picture_src: "http://picturesrc", bio: "some bio and then some more bio")
    expect(solar_system).to be_invalid
  end
end
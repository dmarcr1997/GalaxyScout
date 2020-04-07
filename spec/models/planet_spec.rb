require 'rails_helper'

RSpec.describe Planet, type: :model do
  it "is valid" do
    planet = Planet.new(name: "Mars", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: 'half million miles')
    expect(planet).to be_valid
  end

  it "is invalid with no name" do
    planet = Planet.new(name: "Mars", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: 'half million miles')
    expect(planet).to be_invalid
  end

  it "is invalid with no picture" do
    planet = Planet.new(name: "Mars", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: 'half million miles')
    expect(planet).to be_invalid
  end

  it "is invalid when non-unique" do
    Planet.create(name: "Mars", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: 'half million miles')
    planet = Planet.new(name: "Mars", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: 'half million miles')
    expect(planet).to be_invalid
  end
end

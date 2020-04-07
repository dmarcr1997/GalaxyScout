require 'rails_helper'

RSpec.describe Galaxy, type: :model do

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
    galaxy = Galaxy.new(name: "Milky Way", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: '1 million miles')
    valid_album.galaxies << galaxy
    expect(galaxy).to be_valid
  end

  it "is invalid with no name" do
    galaxy = Galaxy.new(picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: '1 million miles')
    valid_album.galaxies << galaxy
    expect(galaxy).to be_invalid
  end

  it "is invalid with no picture" do
    galaxy = Galaxy.new(name: "Milky Way", bio: "some bio and then some more bio", size: '1 million miles')
    valid_album.galaxies << galaxy
    expect(galaxy).to be_invalid
  end

  it "is invalid when non-unique" do
    Galaxy.create(name: "Milky Way", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: '1 million miles')
    galaxy = Galaxy.new(name: "Milky Way", picture_src: "http://picturesrc", bio: "some bio and then some more bio", size: '1 million miles')
    expect(galaxy).to be_invalid
  end
end

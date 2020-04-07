require 'rails_helper'

Rspec.describe Album, type: :model do
    
  let(:valid_attrs) do
    {
      title: "You Won't Believe These True Facts",
      date: "2020-01-11",
      center: "Johson"
      creator: "Neil"
      description: "Lorem ipsum"
      nasa_id: '223C'
      href: "http://example.com/here"
    }
  end

  let(:valid_album) { Album.new(valid_attrs) }
  let(:missing_title) { Album.new(valid_attrs.except(:title)) }
  let(:missing_date) { Album.new(valid_attrs.except(:date)) }
  let(:missing_description) { Album.new(valid_attrs.except(:description)) }
  let(:missing_href) { Album.new(valid_attrs.except(:href)) }
  
  it "is valid" do
    expect(valid_album).to be_valid
  end

  it "is invalid without a title" do
    expect(missing_title).to be_invalid
  end

  it "is invalid without a date" do
    expect(missing_date).to be_invalid
  end
  
  it "is invalid without a description" do
    expect(missing_description).to be_invalid
  end
  
  it "is invalid without a href" do
    expect(missing_href).to be_invalid
  end
end

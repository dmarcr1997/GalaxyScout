class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string  :title
      t.datetime  :date
      t.string  :center
      t.string  :creator
      t.text    :description
      t.string  :nasa_id
      t.timestamps
    end
  end
end

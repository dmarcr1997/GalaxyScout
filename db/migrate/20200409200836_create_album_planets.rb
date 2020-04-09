class CreateAlbumPlanets < ActiveRecord::Migration[6.0]
  def change
    create_table :album_planets do |t|
      t.integer :album_id
      t.integer :planet_id 
    end
  end
end

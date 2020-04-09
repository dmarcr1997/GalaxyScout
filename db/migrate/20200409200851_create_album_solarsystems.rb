class CreateAlbumSolarsystems < ActiveRecord::Migration[6.0]
  def change
    create_table :album_solarsystems do |t|
      t.integer :album_id
      t.integer :solar_system_id
      
    end
  end
end

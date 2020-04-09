class CreateAlbumRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :album_relations do |t|
      t.integer :album_id
      t.integer :galaxy_id
      t.integer :solar_system_id
      t.integer :planet_id
    end
  end
end

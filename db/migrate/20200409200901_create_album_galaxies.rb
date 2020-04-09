class CreateAlbumGalaxies < ActiveRecord::Migration[6.0]
  def change
    create_table :album_galaxies do |t|
      t.integer :album_id
      t.integer :galaxy_id
    end
  end
end

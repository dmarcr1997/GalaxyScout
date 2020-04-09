class Deletecolumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :planets, :album_id
    remove_column :planets, :solar_system_id
    remove_column :solar_systems, :album_id
    remove_column :solar_systems, :galaxy_id
    remove_column :galaxies, :album_id
  end
end

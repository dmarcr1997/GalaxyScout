class AddUserId < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :user_id, :integer
    add_column :galaxies, :album_id, :integer
    add_column :solar_systems, :album_id, :integer
    add_column :solar_systems, :galaxy_id, :integer
    add_column :planets, :album_id, :integer
    add_column :planets, :solar_system_id, :integer
    
    
  end
end

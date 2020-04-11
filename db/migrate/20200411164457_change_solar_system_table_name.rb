class ChangeSolarSystemTableName < ActiveRecord::Migration[6.0]
  def change
    rename_table :solar_systems, :objects
    rename_table :album_solarsystems, :album_objects
  end
end

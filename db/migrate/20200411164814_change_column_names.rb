class ChangeColumnNames < ActiveRecord::Migration[6.0]
  def change
    rename_column :album_objects, :solar_system_id, :object_id
  end
end

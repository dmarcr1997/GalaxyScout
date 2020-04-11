class RenameAlbumObjects < ActiveRecord::Migration[6.0]
  def change
    rename_table :album_objects, :album_space_objs
    rename_table :objects, :space_objs
  end
end

class DeleteAlbumRelations < ActiveRecord::Migration[6.0]
  def change
    drop_table :album_relations 
  end
end

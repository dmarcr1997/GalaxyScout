class ChangeSpaceObjCol < ActiveRecord::Migration[6.0]
  def change
    rename_column :album_space_objs, :object_id, :space_obj_id
  end
end

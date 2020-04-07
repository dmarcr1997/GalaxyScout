class DeletePictures < ActiveRecord::Migration[6.0]
  def change
    drop_table :pictures
    add_column :albums, :href, :string
  end
end

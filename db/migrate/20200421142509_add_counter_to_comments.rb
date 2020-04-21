class AddCounterToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :comments_count, :integer
    remove_column :albums, :options
  end
end

class AddSizetoObjects < ActiveRecord::Migration[6.0]
  def change
    add_column :objects, :size, :string
  end
end

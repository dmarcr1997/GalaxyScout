class AddOptions < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :options, :text
  end
end

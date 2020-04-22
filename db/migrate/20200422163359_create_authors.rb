class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.integer :user_id
      t.timestamps
    end
    remove_column :albums, :user_id
    add_column :albums, :author_id, :integer
  end
end

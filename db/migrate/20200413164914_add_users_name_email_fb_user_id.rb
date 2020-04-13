class AddUsersNameEmailFbUserId < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :username, :name
    add_column :users, :email, :string
    add_column :users, :uid, :string
    add_column :users, :image, :string
  end
end

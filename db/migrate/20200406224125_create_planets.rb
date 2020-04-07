class CreatePlanets < ActiveRecord::Migration[6.0]
  def change
    create_table :planets do |t|
      t.string  :name
      t.string  :picture_src
      t.text    :bio
      t.string  :size
      t.timestamps
    end
  end
end

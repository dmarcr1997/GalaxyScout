class CreateGalaxies < ActiveRecord::Migration[6.0]
  def change
    create_table :galaxies do |t|

      t.timestamps
    end
  end
end

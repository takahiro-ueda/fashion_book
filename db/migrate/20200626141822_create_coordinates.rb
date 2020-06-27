class CreateCoordinates < ActiveRecord::Migration[5.2]
  def change
    create_table :coordinates do |t|
      t.string :image
      t.text :introduction, null: false
      t.integer :sex, null: false, default: 1
      t.integer :height, null: false
      t.integer :age, null: false
      t.integer :month, null: false
      t.integer :hairstyle, null: false
      t.references :user,       null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateCoordinates < ActiveRecord::Migration[5.2]
  def change
    create_table :coordinates do |t|
      t.string :image
      t.string :name, null: false
      t.text :introduction, null: false
      t.references :gender, null: false
      t.references :height, null: false
      t.references :age, null: false
      t.references :month, null: false
      t.references :hairstyle, null: false
      t.references :user,       null: false, foreign_key: true

      t.timestamps
    end
  end
end

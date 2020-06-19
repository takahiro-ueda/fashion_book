class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :introduction, null: false
      t.string :image
      t.references :category, null: false
      t.references :size, null: true
      t.references :brand, null: true
      t.references :season, null: true
      t.references :color, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end

class CreateBrowsingHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :browsing_histories do |t|
      t.references :coordinate, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.integer :condition, default: 1, null: false
      t.string :price, null: false
      t.boolean :available, default: true, null: false

      t.timestamps
    end
  end
end

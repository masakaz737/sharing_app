class AddUniqueIndexOnItemAndCategory < ActiveRecord::Migration[5.2]
  def change
    add_index :item_categories, [:item_id, :category_id], unique: true
  end
end

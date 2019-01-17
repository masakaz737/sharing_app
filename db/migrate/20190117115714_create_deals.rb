class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.references :item, foreign_key: true, null: false
      t.references :lender, null: false
      t.references :borrower, null: false
      t.string :unit_price, null: false

      t.timestamps
    end

    add_foreign_key :deals, :users, column: "lender_id"
    add_foreign_key :deals, :users, column: "borrower_id"
  end
end

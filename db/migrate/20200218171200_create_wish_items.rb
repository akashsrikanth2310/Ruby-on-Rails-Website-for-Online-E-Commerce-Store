class CreateWishItems < ActiveRecord::Migration[6.0]
  def change
    create_table :wish_items do |t|
      t.integer :quantity, default: 1
      t.integer :item_id
      t.integer :wish_id

      t.timestamps
    end
  end
end

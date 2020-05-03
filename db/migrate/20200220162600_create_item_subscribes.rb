class CreateItemSubscribes < ActiveRecord::Migration[6.0]
  def change
    create_table :item_subscribes do |t|
      t.integer :userid
      t.integer :itemid

      t.timestamps
    end
  end
end

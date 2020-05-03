class CreateReturnItems < ActiveRecord::Migration[6.0]
  def change
    create_table :return_items do |t|
      t.integer :order_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end

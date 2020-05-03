class AddColumnsToReturnItem < ActiveRecord::Migration[6.0]
  def change
    add_column :return_items, :item_id, :integer
  end
end

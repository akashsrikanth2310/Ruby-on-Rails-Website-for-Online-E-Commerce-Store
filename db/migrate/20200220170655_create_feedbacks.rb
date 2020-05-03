class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :email
      t.string :comments

      t.timestamps
    end
  end
end

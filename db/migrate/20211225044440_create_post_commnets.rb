class CreatePostCommnets < ActiveRecord::Migration[5.2]
  def change
    create_table :post_commnets do |t|
      t.text :comment
      t.integer :user_id
      t.integer :post_image_id

      t.timestamps
    end
  end
end

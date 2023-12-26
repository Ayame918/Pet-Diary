class CreatePostBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :post_bookmarks do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
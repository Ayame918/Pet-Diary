class CreateCommentFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_favorites do |t|
      t.integer :user_id
      t.integer :comment_id
      
      t.timestamps
    end
  end
end

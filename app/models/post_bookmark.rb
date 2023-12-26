class PostBookmark < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 同じ投稿を複数回お気に入り登録させない
  validates :user_id, uniqueness: { scope: :post_id }

end
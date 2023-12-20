class CommentFavorite < ApplicationRecord
  has_many :user
  has_many :post_comment

end

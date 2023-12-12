class PostComment < ApplicationRecord
  has_many :post
  has_many :user
end

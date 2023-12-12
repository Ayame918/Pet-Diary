class PostTag < ApplicationRecord
  has_many :post
  has_many :tag
end

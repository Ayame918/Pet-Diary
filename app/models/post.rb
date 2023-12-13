class Post < ApplicationRecord
  has_many :user
  has_one_attached :image
  has_one_attached :video
end

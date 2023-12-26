class Relationship < ApplicationRecord
  #class_name: "User"オプションを使用することで、followerとfollowedの関連付けにはUserモデルが使用
  #関連付け名を指定し、Userモデルとの関連付けが正しく行われる
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
end

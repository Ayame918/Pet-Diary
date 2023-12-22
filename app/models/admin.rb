class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed
  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower
  has_one_attached :profile_image
  has_many :post_tags, dependent: :destroy
  has_many :post_favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_bookmarks, dependent: :destroy


  def self.authenticate(email, password)
    # 特定の管理者のメールアドレスとパスワードの場合のみ認証を許可
    if email == 'Portfolio@PetDiary' && password == '654321'
      find_by(email: email)&.authenticate(password)
    else
      nil
    end
  end
  
  def get_profile_image(width, height)
    if profile_image.attached?
       profile_image.variant(resize_to_limit: [width, height]).processed
    else
      'no_image.jpg'
    end
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
end

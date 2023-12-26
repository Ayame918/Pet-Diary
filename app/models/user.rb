class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { minimum: 1, maximum: 20 }
  validates :introduction, length: { maximum: 100 }


  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed
  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower
  # プロフィール画像を保存できるように設定
  has_one_attached :profile_image
  # ユーザーが投稿を取得
  has_many :posts, dependent: :destroy
  # 投稿に対するいいねを取得
  has_many :post_favorites, dependent: :destroy
  # 投稿に対するコメントを取得
  has_many :post_comments, dependent: :destroy
  # 投稿に対するブックマーク
  has_many :post_bookmarks, dependent: :destroy


  # 指定したユーザーをフォローする
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  # 指定したユーザーのフォローを解除する
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  # 指定したユーザーをフォローしているかどうかを判定
  def following?(user)
    followings.include?(user)
  end

  def get_profile_image(width, height)
    if profile_image.attached?
       profile_image.variant(resize_to_limit: [width, height]).processed
    else
      'no_image1.png'
    end
  end

  # 退会済みかどうか確認
  def active_for_authentication?
    super && is_active?
  end

  # ユーザー退会済みの場合のメッセージ
  def inactive_message
    is_active? ? super : :locked
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest #find_or_create_byは、データの検索・作成を自動的に判断して処理を行うRailsのメソッド
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64.encode('utf-8') #ランダムな文字列を生成するRubyのメソッドの一種
      user.name = "ゲスト"
    end
  end

  def guest_user? #メールアドレスがゲストユーザーのものであるかを判定しtrueかfalseの値を返す
    email == GUEST_USER_EMAIL
  end

  def self.looks(search, word)
    if search == "perfect_match"
      User.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      User.where("name LIKE?","%#{word}%")
    else
      User.all
    end
  end
end

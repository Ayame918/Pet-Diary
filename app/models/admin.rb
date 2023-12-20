class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.authenticate(email, password)
    # 特定の管理者のメールアドレスとパスワードの場合のみ認証を許可
    if email == 'Portfolio@PetDiary' && password == '654321'
      find_by(email: email)&.authenticate(password)
    else
      nil
    end
  end

  
end

class User < ApplicationRecord
  before_destroy :admin_user_destroy
  before_update :admin_user_update

  has_many :tasks, foreign_key: :user_id, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  def admin_user_destroy
    if admin && User.where(admin: true).count <= 1
      throw :abort
     # redirect_to , alert: 'ユーザーの削除に失敗しました'
    end
  end

  private


   def admin_user_update
    if self.admin == false && User.where(admin: true).count <= 1
     # binding.pry
      #&& User.where.not(admin: false).count == 0
      #アドミンユーザーが１以下、自分がアドミンユーザー、
      #&& self.admin = false
      throw :abort
      #errors.add(:admin, ": 消しちゃダメです")
     end
    # binding.pry
    end

end

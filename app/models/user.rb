class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :profile_image, destroy: false
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books,through: :favorites, source: :book
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following_user, through: :followers, source: :followed
  has_many :follower_user, through: :followeds, source: :follower

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # ユーザーをフォローする
  def follow(user_id)
    followers.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end
  # フォローの確認を行う
  def following?(user)
    following_user.include?(user)
  end

  def self.serch_for(content,method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content+'%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%'+content)
    else
      User.where('name LIKE ?', '%'+content+'%')
    end
  end

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
end

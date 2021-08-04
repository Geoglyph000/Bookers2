class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def self.search_for(content, method)
    if method == 'match'
      User.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', "#{content}%")
    elsif method == 'backward'
      Book.where('title LIKE ?', "%#{content}")
    else
      Book.where('title LIKE ?', "%#{content}%")
    end
  end

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  attachment :profile_image

  validates :name, length: {minimum: 2, maximum: 20}, uniqueness: true
  validates :introduction, length: {maximum: 50}

end

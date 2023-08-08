class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image

  has_many :active_follow, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many :follower_lists, through: :active_follow, source: :followed
  has_many :passive_follow, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followed_lists, through: :passive_follow, source: :follower

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum:50 }

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def following?(user)
    follower_lists.include?(user)
  end

  def follow(user)
    active_follow.create(followed_id: user.id)
  end

  def unfollow(user)
    active_follow.find_by(followed_id: user.id).destroy
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  scope :all_except, ->(user) { where.not(id: user.id) }

  def friend_requests
    inverse_friendships.where(accepted: nil)
  end

  def friends_relationships
    friendships.where(accepted: true) + inverse_friendships.where(accepted: true)
  end

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.accepted }
    friends_array = friends_array + inverse_friendships.map { |friendship| friendship.user if friendship.accepted }
  end

  def friend?(user)
    friends.include?(user)
  end

  def friendship_requested?(user)
    friends_array = friendships.map { |friendship| friendship.friend if !friendship.accepted }
    friends_array = friends_array + inverse_friendships.map { |friendship| friendship.user if !friendship.accepted }
    friends_array.include?(user)
  end
  
end

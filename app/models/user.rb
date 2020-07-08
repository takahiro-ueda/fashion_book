class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address
  
  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :coordinates, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_coordinates, through: :likes, source: :coordinate
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_coordinates, through: :bookmarks, source: :coordinate

  has_many :browsing_histories, dependent: :destroy

  validates :nickname, :birth_date, :sex, presence: true
  validates :nickname, presence: true, length: { minimum: 1 ,maximum:20  }
  validates :password, presence: true, length: { minimum: 6 ,maximum:128 }
  validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },uniqueness: true
end

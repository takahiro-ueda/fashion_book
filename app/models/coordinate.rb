class Coordinate < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  belongs_to_active_hash :height
  belongs_to_active_hash :age
  belongs_to_active_hash :month
  belongs_to_active_hash :hairstyle

  belongs_to :user, optional: true
  has_many :items
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  mount_uploader :image, ImageUploader
  validates :name,
    length: { maximum:50, message: "入力は５０文字までです。"}
  validates :introduction,
    length: { maximum:2000, message: "入力は２０００文字までです。"}
end

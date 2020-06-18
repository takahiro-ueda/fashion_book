class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :size
  belongs_to_active_hash :brand
  belongs_to_active_hash :season
  belongs_to_active_hash :color

  belongs_to :user, optional: true
  belongs_to :category


  mount_uploader :image, ImageUploader
  validates :name, :introduction, :category_id, :brand_id, :price, presence: true, unless: :image?

  validates :name,
    length: { maximum:40, message: "入力は４０文字までです。"}
  validates :introduction,
    length: { maximum:600, message: "入力は６００文字までです。"}
  validates :price,
  inclusion: { in: (300..9999999) , message: "入力は数字のみ300〜9999999までです。"}
end

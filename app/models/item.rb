class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :brand
  belongs_to_active_hash :color
  belongs_to_active_hash :season
  # has_many :item_seasons, dependent: :destroy
  # has_many :seasons, through: :item_seasons, source: :season, dependent: :destroy
  # accepts_nested_attributes_for :item_seasons, allow_destroy: true

  # has_many :item_colors, dependent: :destroy
  # has_many :colors, through: :item_colors, source: :color, dependent: :destroy
  # accepts_nested_attributes_for :item_colors, allow_destroy: true
  # belongs_to :color, optional: true
  # belongs_to :season, optional: true
  belongs_to :user, optional: true
  belongs_to :category
  belongs_to :items_size
  belongs_to :coordinate, optional: true

  mount_uploader :image, ImageUploader
  validates :name, :introduction, :category_id, :brand_id, :price, presence: true, unless: :image?

  validates :name,
    length: { maximum:40, message: "入力は４０文字までです。"}
  validates :introduction,
    length: { maximum:600, message: "入力は６００文字までです。"}
  validates :price,
  inclusion: { in: (300..9999999) , message: "入力は数字のみ300〜9999999までです。"}
end

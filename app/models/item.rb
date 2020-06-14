class Item < ApplicationRecord
  # mount_uploader :image, ImageUploader

  belongs_to :user, optional: true



  validates :name,
    length: { maximum:40, message: "入力は４０文字までです。"}
  validates :introduction,
    length: { maximum:600, message: "入力は６００文字までです。"}
  # validates :brand,
  #   length: { maximum:40, message: "入力は４０文字までです"}
  validates :price,
  inclusion: { in: (300..9999999) , message: "入力は数字のみ300〜9999999までです。"}
end

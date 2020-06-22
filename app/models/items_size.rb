class ItemsSize < ApplicationRecord
  has_many :items
  has_many :category_sizes, dependent: :destroy
  has_many :categories, through: :category_sizes, source: :category, dependent: :destroy
  has_ancestry
end

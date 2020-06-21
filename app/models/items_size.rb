class ItemsSize < ApplicationRecord
  has_many :items
  has_many :category_sizes, dependent: :destroy
  has_many :categories, through: :category_sizes#, source: :items_size, dependent: :destroy

  # has_many :post_categories, dependent: :destroy
  # has_many :categories, through: :post_categories, source: :category, dependent: :destroy
  # accepts_nested_attributes_for :post_categories, allow_destroy: true

  has_ancestry
end

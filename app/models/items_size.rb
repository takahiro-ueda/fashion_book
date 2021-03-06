class ItemsSize < ApplicationRecord
  has_many :items
  has_many :category_sizes, dependent: :destroy
  has_many :categories, through: :category_sizes, source: :category, dependent: :destroy
  accepts_nested_attributes_for :category_sizes, allow_destroy: true
  has_ancestry
end

class Category < ApplicationRecord
  has_many :items
  has_many :category_sizes, dependent: :destroy
  has_many :items_sizes, through: :category_sizes, source: :items_size, dependent: :destroy
  
  has_ancestry
end

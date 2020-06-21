class CategorySize < ApplicationRecord
  belongs_to :category#, optional: true
  belongs_to :items_size#, optional: true

  validates :items_size_id, presence:true
  validates :category_id, presence:true
end

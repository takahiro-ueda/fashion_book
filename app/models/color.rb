class Color < ApplicationRecord
  has_one :item

  validates :name, presence: true
end

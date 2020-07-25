class Season < ApplicationRecord
  has_many :item 

  validates :name, presence: true
end

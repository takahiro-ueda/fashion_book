class Like < ApplicationRecord
  belongs_to :coordinate, counter_cache: :likes_count
  belongs_to :user

  validates :user_id, presence: true
  validates :coordinate_id, presence: true
  validates_uniqueness_of :coordinate_id, scope: :user_id
end

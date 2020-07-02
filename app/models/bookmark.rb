class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :coordinate, counter_cache: :bookmarks_count

  validates :user_id, presence: true
  validates :coordinate_id, presence: true
  validates_uniqueness_of :coordinate_id, scope: :user_id
end

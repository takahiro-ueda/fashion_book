class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :coordinate, optional: true

  validates :content, presence: true
end

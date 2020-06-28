class Coordinate < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :gender
  belongs_to_active_hash :height
  belongs_to_active_hash :age
  belongs_to_active_hash :month
  belongs_to_active_hash :hairstyle

end

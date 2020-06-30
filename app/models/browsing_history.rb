class BrowsingHistory < ApplicationRecord
  belongs_to :user
  belongs_to :coordinate, optional: true
end

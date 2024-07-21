class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :content

  validates :rating, inclusion: { in: 1..5 }
end

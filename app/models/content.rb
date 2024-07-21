class Content < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings

  validates :title, :description, :category, :thumbnail_url, :content_url, presence: true
  validates :category, inclusion: { in: %w(game video artwork music) }
end

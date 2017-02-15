class Category < ApplicationRecord
  has_many :news
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 6}

  # scope :search, -> (keyword){where "name like ? or description like ?",
  #   "%#{keyword}%", "%#{keyword}%"}
end

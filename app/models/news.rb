class News < ApplicationRecord
  belongs_to :category

  validates :title, presence: true
  validates :content, presence: true, length: {minimum: 5}
  validates :author, presence: true

  # scope :search, -> keyword do
  #   where "title like ? or content like ?", "%#{keyword}%", "%#{keyword}%" if keyword.present?
  # end

  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end
end

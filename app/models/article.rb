class Article < ApplicationRecord
  has_many :contributions
  has_many :authors, through: :contributions

  validates :title, :content, presence: true

  attribute :original_author
end

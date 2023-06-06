class Article < ApplicationRecord
  belongs_to :author

  validates :title, :content, presence: true

  attribute :original_author
end

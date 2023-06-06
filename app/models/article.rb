class Article < ApplicationRecord

  validates :title, :content, presence: true

  attribute :original_author
end

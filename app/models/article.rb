class Article < ApplicationRecord
  belongs_to :author

  validates :title, :content, presence: true

  attribute :original_author
  attribute :new_author_fn
  attribute :new_author_ln

end

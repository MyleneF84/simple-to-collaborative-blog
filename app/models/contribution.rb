class Contribution < ApplicationRecord
  belongs_to :article
  belongs_to :author, inverse_of: :contributions, foreign_key: 'author_id'

  has_rich_text :rich_content
end

class Contribution < ApplicationRecord
  belongs_to :article
  belongs_to :author

  attribute :content
end

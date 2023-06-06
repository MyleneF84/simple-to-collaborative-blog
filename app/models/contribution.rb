class Contribution < ApplicationRecord
  belongs_to :article
  belongs_to :author
end

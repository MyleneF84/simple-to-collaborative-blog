class Membership < ApplicationRecord
  belongs_to :author
  belongs_to :group

  validates :group_id, uniqueness: { scope: :author_id }
end

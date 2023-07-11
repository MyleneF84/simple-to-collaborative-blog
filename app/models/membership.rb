class Membership < ApplicationRecord
  belongs_to :author
  belongs_to :group
end

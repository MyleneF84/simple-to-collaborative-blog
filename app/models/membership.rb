class Membership < ApplicationRecord
  belongs_to :author
  belongs_to :group
  # accepts_nested_attributes_for :group

end

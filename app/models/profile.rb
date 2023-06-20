class Profile < ApplicationRecord
  # has_one :user
  # has_one :author

  validates :first_name, :last_name, presence: true


end

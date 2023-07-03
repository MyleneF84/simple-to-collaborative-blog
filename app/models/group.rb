class Group < ApplicationRecord
  has_many :memberships
  has_many :authors, through: :memberships

  has_many :articles
  attribute :name
end

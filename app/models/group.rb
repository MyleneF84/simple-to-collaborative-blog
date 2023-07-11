class Group < ApplicationRecord
  has_many :memberships
  has_many :articles
  # has_many :authors, through: :articles
  has_many :authors, through: :memberships
  accepts_nested_attributes_for :memberships

  # attribute :name
end

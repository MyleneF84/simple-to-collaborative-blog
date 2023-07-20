class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  accepts_nested_attributes_for :memberships, allow_destroy: true, update_only: true, reject_if: proc { |attr| attr[:author_id].blank? }
  has_many :articles, dependent: :destroy
  has_many :authors, through: :memberships
  # accepts_nested_attributes_for :authors

  attribute :name
end

class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  accepts_nested_attributes_for :memberships, allow_destroy: true, update_only: true, reject_if: proc { |attr| attr[:author_id].blank? }
  has_many :articles, dependent: :destroy
  has_many :authors, through: :memberships
  validates :name, presence: true, uniqueness: true

  validate :unique_author_combination

  private

  def unique_author_combination
    sorted_ids = memberships.map(&:author_id).sort
    if Group.joins(:memberships).where(memberships: {author_id: sorted_ids.first}).ids.any? do |group_id|
      Group.find(group_id).authors.ids.sort == sorted_ids
    end
      errors.add(:base, "This group already exists :(")
    end
  end
end

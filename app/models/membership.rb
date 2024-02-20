class Membership < ApplicationRecord
  belongs_to :author
  belongs_to :group



  # Group.from(Group.joins(:memberships).where(memberships: {author_id: 1}), 'groups').joins(:memberships).where(memberships: {author_id: 28}).pluck(:id)
  # Group.from(Group.from(Group.joins(:memberships).where(memberships: {author_id: 1}), 'groups').joins(:memberships).where(memberships: {author_id: 28}), 'groups').joins(:memberships).group(:group_id).having('count(*) = 2').pluck(:id)
  Group.joins(:memberships).where(memberships: {author_id: ids}).group(:group_id).having("count (*) = ?", ids.size)
end

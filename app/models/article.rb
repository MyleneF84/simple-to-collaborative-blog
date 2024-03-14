class Article < ApplicationRecord
  include ExportPdf

  has_many :contributions, dependent: :destroy
  has_many :writers, through: :contributions, source: :author
  has_many :comments, as: :commentable, dependent: :destroy

  belongs_to :group, optional: true
  accepts_nested_attributes_for :group
  has_many :memberships, through: :group
  accepts_nested_attributes_for :memberships, reject_if: proc { |attr| attr[:author_id].blank? }

  has_many :authors, through: :group
  has_many :bookmarks

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [150,150]
    attachable.variant :medium, resize_to_limit: [500,500]
  end

  has_rich_text :rich_content

  validates :title, :rich_content, presence: true

  acts_as_taggable_on :tags

  paginates_per 10

  TAGS = ["Ruby", "Rails", "Front-end", "Back-end"]

  # attribute :list_ids

  def names_list
    case authors.length
      when 1
        [authors.first]
      when 2
        [authors.first, ' & ', authors.last]
      else
        x = authors.count - 2
        rest = " #{x} other#{ x > 1 ? "s" : ""}"
        [authors.first, ', ', authors.second, ' &', rest]
      end
  end

  def authors
    group.present? ? super : writers
  end
end

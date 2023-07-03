class Article < ApplicationRecord
  include ExportPdf

  has_many :contributions, dependent: :destroy
  has_many :authors, through: :contributions
  has_many :comments, as: :commentable, dependent: :destroy


  belongs_to :group
  # has_many :authors, through: :group

  validates :title, :content, presence: true

  acts_as_taggable_on :tags

  paginates_per 20

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
end

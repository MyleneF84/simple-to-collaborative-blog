class Article < ApplicationRecord
  has_many :contributions, dependent: :destroy
  has_many :authors, through: :contributions
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :content, presence: true

  acts_as_taggable_on :tags

  paginates_per 20

  def names_list
    case authors.count
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

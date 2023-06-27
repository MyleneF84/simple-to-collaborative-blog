class Article < ApplicationRecord
  has_many :contributions, dependent: :destroy
  has_many :authors, through: :contributions
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :content, presence: true

  # attribute :original_author

  acts_as_taggable_on :tags

  def names_list
    # names = authors.map(&:full_name).uniq
    case authors.count
      when 1
        # "#{authors.first}"
        [authors.first]
      when 2
        # "#{authors.first} and #{authors.last}"
        [authors.first, ' & ', authors.last]
      else
        # "#{authors.first}, #{authors.second} and #{x = authors.count - 2} other#{ x > 1 ? "s" : ""}"
        x = authors.count - 2
        rest = " #{x} other#{ x > 1 ? "s" : ""}"
        [authors.first, ', ', authors.second, ' &', rest]
      end
  end
end

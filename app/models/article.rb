class Article < ApplicationRecord
  has_many :contributions, dependent: :destroy
  has_many :authors, through: :contributions
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :content, presence: true

  # attribute :original_author

  acts_as_taggable_on :tags

  def names_list
    names = authors.map(&:full_name).uniq
    case names.count
      when 1
        "#{names.first}"
      when 2
        "#{names.first} and #{names.last}"
      else
        "#{names.first}, #{names.second} and #{x = names.count - 2} other#{ x > 1 ? "s" : ""}"
      end
  end
end

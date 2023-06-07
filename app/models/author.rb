class Author < ApplicationRecord
  has_many :contributions, dependent: :nullify
  has_many :articles, through: :contributions
  has_many :comments, as: :commentable


  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name.chr.capitalize}."
  end
end

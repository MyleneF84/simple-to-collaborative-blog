class Author < ApplicationRecord
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name.chr.capitalize}."
  end
end

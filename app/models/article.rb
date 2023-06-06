class Article < ApplicationRecord
  belongs_to :author

  validates :title, :content, presence: true

end

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :author

  validates :content, presence: true
end

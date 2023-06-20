class Author < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contributions, dependent: :nullify
  has_many :articles, through: :contributions
  has_many :comments, as: :commentable

  belongs_to :profile
  delegate_missing_to :profile

  validates :email, presence: true

  def full_name
    "#{first_name} #{last_name.chr.capitalize}."
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, as: :commentable

  validates :first_name, :last_name, :email, presence: true

  # delegate_missing_to :profile

  def full_name
    "#{first_name} #{last_name.chr.capitalize}."
  end

end

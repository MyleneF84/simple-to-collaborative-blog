class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :profile
  validates :email, presence: true

  delegate_missing_to :profile

  def full_name
    "#{first_name} #{last_name.chr.capitalize}."
  end

end

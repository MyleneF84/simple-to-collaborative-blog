class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable

        #  devise :database_authenticatable, :registerable,
        #  :recoverable, :rememberable, :validatable


  has_many :comments, as: :commentable
  has_many :accesses
  has_many :spaces, through: :accesses

  validates :first_name, :last_name, :email, presence: true

  after_create :allow_userspace_access

  def allow_userspace_access
    Access.create!(user_id: User.last.id, space_id: 2)
  end

  def full_name
    "#{first_name} #{last_name.chr.capitalize}."
  end

  def has_access?
    spaces.pluck(:name).include?("Authorspace")
  end

end

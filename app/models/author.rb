class Author < User
  has_many :contributions, inverse_of: :author, dependent: :nullify
  has_many :articles, through: :contributions

  # self.abstract_class = true
  # delegate_missing_to :user

  # validates :email, presence: true



end

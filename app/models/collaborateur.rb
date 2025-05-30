class Collaborateur < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :affectations, dependent: :destroy
  has_many :restaurants, through: :affectations
  has_many :fonctions, through: :affectations
  # validations
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  def full_name
    "#{first_name} #{last_name}"
  end

end
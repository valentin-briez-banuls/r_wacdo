class Fonction < ApplicationRecord
  has_many :affectations, dependent: :destroy
  has_many :collaborateurs, through: :affectations
  # validations
  validates :title, presence: true
end
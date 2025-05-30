class Restaurant < ApplicationRecord
  has_many :affectations, dependent: :destroy
  has_many :collaborateurs, through: :affectations
  # validations
  validates :name, :address, :postal_code, :city, presence: true
end

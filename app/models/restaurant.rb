class Restaurant < ApplicationRecord
  has_many :affectations, dependent: :destroy
  has_many :collaborateurs, through: :affectations

  validates :name, :address, :postal_code, :city, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name city address created_at]
  end
end

class Fonction < ApplicationRecord
  has_many :affectations, dependent: :destroy
  has_many :collaborateurs, through: :affectations

  validates :title, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[title created_at]
  end
end

class Restaurant < ApplicationRecord
  # Tes associations ici
  has_many :affectations
  has_many :collaborateurs, through: :affectations
  # etc.

  # Autoriser les associations ransackables
  def self.ransackable_associations(auth_object = nil)
    ["affectations", "collaborateurs"]
  end

  # Autoriser aussi les attributs recherchables si tu veux (exemple)
  def self.ransackable_attributes(auth_object = nil)
    %w[name city address postal_code]
  end
end

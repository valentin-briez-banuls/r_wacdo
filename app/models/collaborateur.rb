class Collaborateur < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :affectations, dependent: :destroy
  has_many :restaurants, through: :affectations
  has_many :fonctions, through: :affectations

  validates :first_name, :last_name, :email, presence: true

  # Mot de passe uniquement si admin et en création ou si un nouveau password est donné
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def password_required?
    admin? && (new_record? || password.present?)
  end

  # === Ajoute ceci pour Ransack ===
  # N’autorise que ces colonnes pour la recherche
  def self.ransackable_attributes(auth_object = nil)
    %w[
      first_name
      last_name
      email
      admin
    ]
  end
end

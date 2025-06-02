require 'rails_helper'

RSpec.describe Affectation, type: :model do
  let(:restaurant) {
    Restaurant.create!(
      name: "Chez Paul",
      address: "12 rue Victor Hugo",
      postal_code: "69001",
      city: "Lyon"
    )
  }
  let(:collaborateur) {
    Collaborateur.create!(
      first_name: "Alice",
      last_name: "Dupont",
      email: "alice#{SecureRandom.hex(4)}@example.com",
      password: "password",
      password_confirmation: "password"
    )
  }
  let(:fonction) {
    Fonction.create!(
      title: "Serveur",
      description: "Responsable du service en salle"
    )
  }

  # Déclare affectation ici, accessible dans les it
  let(:affectation) {
    Affectation.new(
      collaborateur: collaborateur,
      restaurant: restaurant,
      fonction: fonction,
      start_date: Date.today,
      end_date: nil
    )
  }

  it "est valide avec tous les attributs" do
    expect(affectation).to be_valid
  end

  it "n'est pas valide sans collaborateur" do
    affectation.collaborateur = nil
    expect(affectation).not_to be_valid
  end
end

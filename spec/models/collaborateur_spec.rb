require 'rails_helper'

RSpec.describe Collaborateur, type: :model do
  it "est valide avec des attributs valides" do
    collaborateur = Collaborateur.new(
      first_name: "Jean",
      last_name: "Dupont",
      email: "jean@exemple.com",
      password: "password",
      password_confirmation: "password",
      admin: true
    )
    expect(collaborateur).to be_valid
  end

  it "n'est pas valide sans prénom" do
    collaborateur = Collaborateur.new(first_name: nil)
    collaborateur.validate
    expect(collaborateur.errors[:first_name]).to include("can't be blank")
  end

  it "n'est pas valide si le mot de passe est trop court" do
    collaborateur = Collaborateur.new(
      first_name: "Jean",
      last_name: "Dupont",
      email: "jean@exemple.com",
      password: "123",
      password_confirmation: "123"
    )
    expect(collaborateur).not_to be_valid
  end
end

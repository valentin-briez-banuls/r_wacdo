require 'rails_helper'

RSpec.describe Fonction, type: :model do
  it "est valide avec un titre" do
    expect(Fonction.new(title: "Serveur")).to be_valid
  end

  it "n'est pas valide sans titre" do
    fonction = Fonction.new(title: nil)
    fonction.validate
    expect(fonction.errors[:title]).to include("can't be blank")
  end
end

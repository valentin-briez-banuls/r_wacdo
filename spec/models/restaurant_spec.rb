require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "est valide avec un nom, une adresse, un code postal et une ville" do
    restaurant = Restaurant.new(
      name: "Le Gourmet",
      address: "123 rue des Lilas",
      postal_code: "75001",
      city: "Paris"
    )
    expect(restaurant).to be_valid
  end
end

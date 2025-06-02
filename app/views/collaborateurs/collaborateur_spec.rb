# spec/models/collaborateur_spec.rb
require 'rails_helper'

RSpec.describe Collaborateur, type: :model do
  it "is valid with valid attributes" do
    collab = Collaborateur.new(
      first_name: "Test",
      last_name: "User",
      email: "test@user.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(collab).to be_valid
  end

  it "is invalid without an email" do
    collab = Collaborateur.new(email: nil)
    expect(collab).not_to be_valid
  end
end

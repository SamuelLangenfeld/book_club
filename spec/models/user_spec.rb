require 'rails_helper'

RSpec.describe User, :type => :model do
  it "doesn't accept a user without a name, email address, and password" do
    user=User.new(name: "", email: "", password: "")
    expect(user.save).to eq(false)
  end

  it "saves a user with valid name, email address, and password" do
    user=User.new(name: "bob", email: "bob@bob.com", password: "password")
    expect(user.save).to eq(true)
  end

end
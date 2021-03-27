require './app/models/user'

Sequel.seed do
  def run
    [
      {name: "User_01", email: "user_01@example.com", password: "password"},
      {name: "Alex", email: "alex@example.com", password: "password"},
      {name: "Andy", email: "andy@example.com", password: "password"}
    ].each do |values|
      User.create values
    end
  end
end

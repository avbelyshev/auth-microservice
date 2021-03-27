FactoryBot.define do
  factory :user do
    name { generate(:name) }
    email { generate(:email) }
    password { 'password' }
  end
end

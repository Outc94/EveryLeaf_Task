FactoryBot.define do
  factory :user do
    firstname { "Mouhamed" }
    lastname { "Diop" }
    email { "outc@hmail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end

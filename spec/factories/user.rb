FactoryBot.define do
    factory :user do
      name { "Anderson" }
      email { "a@gmail.com" }
      password { "123456" }
      role {1}
    end
  end
  
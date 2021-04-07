FactoryBot.define do
    factory :user do
        username { |u| Faker::Superhero.name }
        password { |p| 'password' }
    end
end
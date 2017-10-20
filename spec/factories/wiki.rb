FactoryGirl.define do
  factory :wiki do
    title { Faker::LordOfTheRings.location }
    body { Faker::ChuckNorris.fact }
    private false
    user
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    description { Faker::Lorem.sentence }
    status { ['pending', 'completed'].sample }
    friend
  end
end

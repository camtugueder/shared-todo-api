# frozen_string_literal: true

FactoryBot.define do
  factory :friend do
    name { Faker::Name.name }
    color { Faker::Color.hex_color }
    group
  end
end

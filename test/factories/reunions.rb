FactoryBot.define do
  factory :reunion do
    sequence(:name) { |n| "Reunion #{n}" }
    event_date { Date.new(2027, 2, 1) }
  end
end

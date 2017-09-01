FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Lorem.word }

    transient do
      create_medical_records false
    end

    after(:create) do |user, evaluator|
      FactoryGirl.create(:medical_record, user: user) if evaluator.create_medical_records
    end
  end

  factory :medical_record do
    note { Faker::Lorem.sentence }

    after(:create) do |medical_record|
      FactoryGirl.create(:prescription, medical_record: medical_record)
    end
  end

  factory :prescription do
    url { Faker::Internet.url }
    description { Faker::Lorem.sentence }
  end
end

FactoryBot.define do
  factory :label1 ,class: Label do
    id { 1 }
    name { 'AA' }
    user_id { nil }
  end

  factory :label2, class: Label do
    id { 2 }
    name { 'BB' }
    user_id { nil }
  end
end

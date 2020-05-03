FactoryBot.define do
  factory :feedback do
    name {"abc"}
    email {"abc@email.com"}
    comments {"Some comments"}
  end

  factory :invalid_feedback, parent: :feedback do |f|
    f.name {nil}
  end

end

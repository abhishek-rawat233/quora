FactoryBot.define do
  factory :questions, class: "Question" do
    title { "first question" }
    content { "content of first question" }
    question_type { "published" }
    url_slug { "first-question" }
  end
end
FactoryBot.define do
  factory :first_question, class: "Question" do
    title { "what question" }
    content { "No content. No answers needed" }
    question_type { "published" }
    url_slug { "what-question" }
  end
end

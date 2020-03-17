FactoryBot.define do
  factory :answer_first, class: 'Answer' do
    content { "lel" }
    base_user { "last" }
    question { "questions" }
  end
end
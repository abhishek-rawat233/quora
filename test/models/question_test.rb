require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @question = build(:question_first)
  end

  test "validations working" do
    question = Question.new
    assert question.valid?, question.errors.full_messages.to_s
  end

  test "question_submitting" do
    assert_not @question.valid?, "If you received this message then question is valid...you doofus"
  end

  test "question answer association" do
    # assert_not
    # write something to check association validation
  end
end

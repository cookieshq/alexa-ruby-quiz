class QuestionsController < ActionController::Base

  def index
    Question.get_by_id(10)
    @questions = Question.get_all
  end
end

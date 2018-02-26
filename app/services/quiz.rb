class Quiz
  attr_accessor :current_question, :answered_questions, :score

  def initialize(session_attributes = {})
    @questions = Question.get_all
    @answered_questions = []
    @score = 0

    @session_attributes = session_attributes

    if @session_attributes.present?
      @answered_questions = @session_attributes['questionsAnswered']
      @score = @session_attributes['quizScore']
      @current_question = Question.get_by_id(@session_attributes['questionId'])
    end
  end

  def start
    @current_question = @questions.sample
    @answered_questions << @current_question.id
    @new_question = false
  end

  def response
    String.new.tap do |string|
      string << "#{@result}, #{@result_reason}, Next question: " if @new_question
      string << @current_question.question

      string << " You can answer: "
      @current_question.options.each do |option|
        string << " or " if option[0] == 4
        string << " #{option[0]} for #{option[1]},"
      end
    end
  end

  def mark(intent_slot)
    answer = intent_slot["ANSWER"]["value"].to_i

    if answer == @current_question.answer
      update_score
      @result = "Correct"
    else
      @result = "Wrong"
      @result_reason = "The correct answer is: #{@current_question.options[@current_question.answer]}"
    end

    set_new_question
  end

  def update_score
    @score = @score + 1
  end

  def set_new_question
    @current_question = @questions.sample
    @answered_questions << @current_question.id
    @new_question = true
  end
end

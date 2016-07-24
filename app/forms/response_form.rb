class ResponseQuestion
  attr_reader :response, :question, :answer_wrappers
  delegate :type, :id, :title, to: :question

  def initialize(response, question)
    @response = response
    @question = question
    @answer_wrappers = question.choices.map do |choice|
      Answer.new(question: question, choice: choice)
    end
    prefill
  end

  def prefill
    answer_wrappers.each_with_index do |response_choice, index|
      if a = response.answers_for(question: response_choice.question, choice: response_choice.choice).first
        answer_wrappers[index] = a
      end
    end
  end
end

class ResponseForm < Reform::Form
  property :ip

  # collection :answers,
  #   prepopulator: :set_up_answers,
  #   skip_if: :skip_blank_answers,
  #   form: AnswerForm,
  #   populate_if_empty: Answer
  #
  def questions
    survey.questions
  end

  def survey_title
    survey.title
  end

  def survey
    model.survey
  end

  # def answers_for(question)
  #   answers.select{|e| e.question == question}
  # end
  #
  # def set_up_answers(options)
  #   questions.each do |question|
  #     question.choices.each do |choice|
  #       found_answers = answers_for(question).select{|e| e.choice == choice}
  #       if found_answers.empty?
  #         self.answers << Answer.new(choice: choice, question: question)
  #       end
  #     end
  #   end
  # end

  def skip_blank_answers(options)
    options[:fragment]['content'].blank?
  end


  def response_questions
    @resposne_questions ||= questions.map do |question|
      ResponseQuestion.new(model, question)
    end
  end
end

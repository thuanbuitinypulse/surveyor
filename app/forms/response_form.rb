class ResponseForm < Reform::Form
  property :ip

  collection :answers,
    prepopulator: :set_up_answers,
    skip_if: :skip_blank_answers,
    form: AnswerForm,
    populate_if_empty: Answer

  def questions
    survey.questions
  end

  def survey_title
    survey.title
  end

  def survey
    model.survey
  end

  def answers_for(question)
    answers.select{|e| e.question == question}
  end

  def set_up_answers(options)
    questions.each do |question|
      question.choices.each do |choice|
        self.answers << Answer.new(choice: choice, question: question) if answers_for(question).empty?
      end
    end
  end

  def skip_blank_answers(options)
    options[:fragment]['content'].blank?
  end
end

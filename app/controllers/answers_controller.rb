class AnswersController < ApplicationController
  def create
    answer = Answer.create!(params.require(:answer).permit!)
    question = answer.question
    next_question = question.next_question(answer)

    if next_question
      redirect_to next_question
    else
      render text: "Quesiton #{question.slug} was the last one."
    end
  end
end

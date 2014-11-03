class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new(question: @question)
  end
end

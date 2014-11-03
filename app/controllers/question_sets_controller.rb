class QuestionSetsController < ApplicationController
  def index
    @question_sets = QuestionSet.all
  end
end

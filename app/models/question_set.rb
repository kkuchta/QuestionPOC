class QuestionSet < ActiveRecord::Base
  belongs_to :head_question, class: Question
end

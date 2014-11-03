class Question < ActiveRecord::Base
  has_many :possible_values

  accepts_nested_attributes_for :possible_values

  # Given that answer, where should we go next?  Nil if nowhere.
  def next_question( answer )
    found_value = possible_values.find do |possible_value|
      possible_value.matches? answer
    end

    if found_value
      Question.find_by_slug(found_value.next_question_slug)
    else
      # We must be at a 'leaf' on the question tree- a termination point.
      # For now, just return nil.
      # TODO: Return a code, like "ended_because_reason_x" so the calling code
      # knows where to go from here.
    end
  end
end

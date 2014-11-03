# A PossibleValue represents a logic branch.  If the question system is a graph,
# this is an edge.  It contains the logic like "If user answers 'yes', go to
# question 7."  A question will have one or more of these so the system knows
# where to go next after a user answers it.
class PossibleValue < ActiveRecord::Base

  # Does this PossibleValue cover the answer provided?
  def matches?(answer)
    # TODO: replace this with single table inheritence and just subclass this class
    case format
    when 'option'
      answer.value == value
    when 'range'
      range = JSON.parse(value)
      answer_value = answer.value.to_i
      answer_value >= range[:min].to_i and answer_value <= range[:max].to_i
    when 'anything'
      true
    end
  end
end

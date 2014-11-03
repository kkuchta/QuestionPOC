class PossibleValue < ActiveRecord::Base
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

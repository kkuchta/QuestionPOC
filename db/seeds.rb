# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Question.destroy_all

question_data = [
  # ---- Ice Cream Set ----
  {
    format: 'dropdown',
    prompt: "What's your favorite kind of ice-cream?",
    slug: 'favorite_icecream',
    options_json: ['vanilla', 'chocolate'].to_json,
    possible_values_attributes: [{
      value: 'vanilla',
      format: 'option',
      next_question_slug: 'why_vanilla'
    },
    {
      value: 'chocolate',
      format: 'option',
      next_question_slug: 'why_chocolate'
    }]
  },

  {
    format: 'text',
    prompt: "You're wrong.  Please write 'chocolate sucks, vanilla is great 100 times below.'",
    slug: 'why_chocolate',
    possible_values_attributes: [{
      format: 'anything',
      next_question_slug: 'sprinkles'
    }]
  },

  {
    format: 'dropdown',
    prompt: "Why do you like vanilla?",
    slug: 'why_vanilla',
    options_json: ["It's the best", "It tastes good"].to_json,
    possible_values_attributes: [{
      format: 'anything',
      next_question_slug: 'sprinkles'
    }]
  },

  {
    format: 'true_false',
    prompt: "Sprinkles are good",
    slug: 'sprinkles',
    possible_values_attributes: [{
      value: 'true',
      format: 'option',
      next_question_slug: 'how_many_sprinkles'
    },
    {
      value: 'false',
      format: 'option',
      next_question_slug: 'toppings'
    }]
  },

  {
    format: 'dropdown',
    prompt: 'how many sprinkles would you like?',
    slug: 'how_many_sprinkles',
    options_json: (0..1000).step(100).to_a.to_json,
    possible_values_attributes: [{
      format: 'range',
      value: {min: 0, max: 100}.to_json,
      next_question_slug: 'exit'
    },
    {
      format: 'anything',
      next_question_slug: 'toppings'
    }]
  },

  {
    format: 'text',
    prompt: "Any other toppings you'd like?",
    slug: 'toppings',
  },

  # ---- Tech Set ----
  {
    format: 'dropdown',
    prompt: "What's your favorite text editor?",
    slug: 'editor',
    options_json: ['vim', 'emacs', 'sublime'].to_json,
    possible_values_attributes: [{
      format: 'anything',
      next_question_slug: 'language'
    }]
  },
  {
    format: 'dropdown',
    prompt: "What's your favorite programming language?",
    slug: 'language',
    options_json: ['Ruby', 'Lisp', 'Java', 'C', 'Whitespace'].to_json,
    possible_values_attributes: [{
      format: 'anything',
      next_question_slug: 'os'
    }]
  },
  {
    format: 'dropdown',
    prompt: "What's your favorite OS?",
    slug: 'os',
    options_json: ['Mac', 'Windows', 'Linux', 'Plan 9 from Bell Labs'].to_json,
  },
]

question_data.each{|question| Question.create!(question) }

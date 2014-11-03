json.array!(@questions) do |question|
  json.extract! question, :id, :format, :prompt, :instructions, :focus, :slug
  json.url question_url(question, format: :json)
end

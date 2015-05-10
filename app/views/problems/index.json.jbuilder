json.array!(@problems) do |problem|
  json.extract! problem, :id, :code, :title, :trial, :success, :percentage
  json.url problem_url(problem, format: :json)
end

json.array!(@employees) do |employee|
  json.extract! employee, :id, :email, :name
  json.url employee_url(employee, format: :json)
end

json.array!(@institutions) do |institution|
  json.extract! institution, :id, :name
  json.url institution_url(institution, format: :json)
end

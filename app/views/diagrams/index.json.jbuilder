json.array!(@diagrams) do |diagram|
  json.extract! diagram, :id
  json.url diagram_url(diagram, format: :json)
end

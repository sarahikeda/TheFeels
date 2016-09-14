json.array!(@relationships) do |relationship|
  json.extract! relationship, :id
  json.url relationship_url(relationship, format: :json)
end

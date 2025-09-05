json.array!(@users) do |user|
  json.extract! user, :id, :institution_id, :name, :email
  json.url user_url(user, format: :json)
end

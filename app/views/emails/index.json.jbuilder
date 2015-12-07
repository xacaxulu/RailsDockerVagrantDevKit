json.array!(@emails) do |email|
  json.extract! email, :id, :address
  json.url email_url(email, format: :json)
end

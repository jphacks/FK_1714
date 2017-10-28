json.array!(@pmemos) do |memo|
  json.extract! memo, :id, :text
  json.url product_url(memo, format: :json)
end

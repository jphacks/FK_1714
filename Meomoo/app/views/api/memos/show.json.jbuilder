json.array!(@memos) do |memo|
  json.array!(@memos.products) do |product|
    json.extract! product, :id, :text
  end

  # json.extract! memo,:id, :text
  # json.url product_url(memo, format: :json)
end

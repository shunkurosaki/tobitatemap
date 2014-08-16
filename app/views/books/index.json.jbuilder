json.array!(@books) do |book|
  json.extract! book, :id, :title, :author, :review, :description
  json.url book_url(book, format: :json)
end

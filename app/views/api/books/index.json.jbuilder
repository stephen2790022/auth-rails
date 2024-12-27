json.array! @books do |book|
  json.title book.title
  json.description book.description
  json.id book.id
end
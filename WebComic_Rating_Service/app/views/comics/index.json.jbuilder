json.array!(@comics) do |comic|
  json.extract! comic, :id, :name, :author, :url, :synopsis, :genre, :rating_art, :rating_story, :rating_overall
  json.url comic_url(comic, format: :json)
end

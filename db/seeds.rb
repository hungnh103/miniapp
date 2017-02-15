25.times do |n|
  name = "cate #{n+1}"
  description = Faker::Lorem.paragraph
  Category.create! name: name, description: description
end


20.times do
  title = Faker::Lorem.sentence
  content = Faker::Lorem.paragraph
  author = Faker::Name.name
  category_id = rand 25 + 1
  if category_id != 0
    News.create! title: title, content: content, author: author, category_id: category_id
  end
end

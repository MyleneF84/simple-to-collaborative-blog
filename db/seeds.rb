# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning Database..."
Article.destroy_all
Author.destroy_all

puts "Creating authors"
10.times do
  author = Author.create!(first_name: Faker::Book.author.split.first, last_name: Faker::Book.author.split.last)
  puts "Created #{author.first_name}"
end

puts "Creating articles"

[*1..10].map do |i|
  article = Article.create!(title: Faker::TvShows::BojackHorseman.tongue_twister, content: Faker::TvShows::BojackHorseman.quote, author_id: i )
  puts "Created #{article.title}"
end

puts "Finished"

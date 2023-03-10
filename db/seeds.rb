# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "csv"

Product.delete_all
Category.destroy_all

# 676.times do
#   Product.create(
#     title:          Faker::Commerce.brand,
#     price:          Faker::Commerce.price,
#     stock_quantity: Faker::Number.between(from: 1, to: 1000)
#   )
# end
#
# puts "Created #{Product.count} Products"

filename = Rails.root.join("db/products.csv")
puts "Loading products from the csv file: #{filename}"

csv_data = File.read(filename)
products = CSV.parse(csv_data, headers: true, encoding: "utf-8")

products.each do |p|
  category = Category.find_or_create_by(name: p["category"])
  if category && category.valid?
    product = category.products.create(
      title:          p["name"],
      price:          p["price"],
      description:    p["description"],
      stock_quantity: p["stock quantity"]
    )
    puts "Invalid product #{p['name']}" unless product&.valid?
  else
    puts "invalid category #{p['category']} for product #{p['name']}."
  end

  # puts m['original_title']
end
puts "Created #{Category.count} categories"
puts "Created #{Product.count} products."

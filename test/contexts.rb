# Require needed files
require './test/sets/categories'
require './test/sets/items'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Categories
  include Contexts::Items

  def create_all
    create_categories
    puts "Built categories"
    create_items
    puts "Built items"
  end
end

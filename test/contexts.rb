# Require needed files
require './test/sets/users'
require './test/sets/categories'
require './test/sets/items'

module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Users
  include Contexts::Categories
  include Contexts::Items

  def create_all
    create_admin_users
    puts "Built admin users"
    create_foster_parent_users
    puts "Built foster_parent users"
    create_categories
    puts "Built categories"
    #create_items
    #puts "Built items"
  end
end

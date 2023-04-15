require './test/contexts'
include Contexts

Given /^an initial setup$/ do
  # context
#   create_customer_users
#   create_employee_users
#   create_customers
#   create_addresses
#   create_categories
#   create_items
#   create_item_prices_retail
#   create_orders
#   create_order_items

  # update order dates to fixed values
#   @alexe_o1.update_attribute(:date, Date.new(2022,2,14))
#   @alexe_o2.update_attribute(:date, Date.new(2022,2,17))
#   @alexe_o3.update_attribute(:date, Date.new(2022,2,11))
#   @melanie_o1.update_attribute(:date, Date.new(2022,2,17))
#   @melanie_o2.update_attribute(:date, Date.new(2022,2,10))
#   @anthony_o1.update_attribute(:date, Date.new(2022,2,17))
#   # update alexe's email and created_at to 2020
#   @alexe.update_attribute(:email, "alex.egan@example.com")
#   @alexe.update_attribute(:created_at, Date.new(2020,2,17))
# end

Given /^no setup yet$/ do
  # assumes initial setup already run as background
  destroy_items
  destroy_customers
end

Given /^a logged in admin$/ do
  step "an initial setup"
  visit login_url
  fill_in "Username", :with => "mark"
  fill_in "Password", :with => "secret"
  click_button "Log In"
end

Given /^a logged in customer$/ do
  step "an initial setup"
  visit login_url
  fill_in "Username", :with => "alexe"
  fill_in "Password", :with => "secret"
  click_button "Log In"
end

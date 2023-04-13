require './test/contexts'
include Contexts

Given /^an initial setup$/ do
  # context
  create_admin_users
  create_foster_parent_users
  create_categories

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
end

Given /^no setup yet$/ do
  # assumes initial setup already run as background
#   destroy_orders
#   destroy_items
#   destroy_addresses
#   destroy_customers
end

Given /^a logged in case_worker$/ do
  step "an initial setup"
  visit login_url
  fill_in "Username", :with => "mark"
  fill_in "Password", :with => "secret"
  click_button "Log In"
end

Given /^a logged in parent$/ do
  step "an initial setup"
  visit login_url
  fill_in "Username", :with => "alexe"
  fill_in "Password", :with => "secret"
  click_button "Log In"
end

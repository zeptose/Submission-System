class Parent < ApplicationRecord
  include AppHelpers::Deletions
  include AppHelpers::Validations
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods

  attr_accessor :username, :password, :password_confirmation, :role
  belongs_to :user
  has_many :assignments

  # Scopes
  scope :alphabetical,  -> { order(:p1_last_name, :p1_first_name) }
  scope :search, ->(term) { where('first_name LIKE ? OR lat_name LIKE ?', "#{term}%", "#{term}%") }

  # Validations
  validates_presence_of :p1_first_name, :p1_last_name
  validates_format_of :phone_number, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"

  validates_numericality_of :open_beds, only_integer: true, greater_than_or_equal_to: 0

  FAMILYSTYLE = ['Traditional', 'Therapeutic', 'Respite'] 

  # Callbacks
  before_save    -> { strip_nondigits_from(:phone_number) }
  before_update :deactive_user_if_parent_inactive


  private
  def deactive_user_if_parent_inactive
    if !self.active && !self.user.nil?
      self.user.active = false
      self.user.save
    end
  end
end

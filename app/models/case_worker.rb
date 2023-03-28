class CaseWorker < ApplicationRecord

  include AppHelpers::Deletions
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods


  belongs_to :user
  has_many :assignments

  # Scopes
  scope :alphabetical,  -> { order(:last_name, :first_name) }


  # Validations
  validates_format_of :phone_number, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"





end

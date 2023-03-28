class Submission < ApplicationRecord
  belongs_to :item
  has_one :assignments
  belongs_to :foster_parent, :through => :assignments


  has_one_attached :file

  #validations
  validates_date :due_date, on_or_before: :today

  #Scope
  scope :for_foster_parent, ->(foster_parent) { where(user_id: foster_parent.id) }
end



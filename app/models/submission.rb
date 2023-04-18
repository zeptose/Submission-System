class Submission < ApplicationRecord
  belongs_to :item
  has_one :assignments
  belongs_to :parent, :through => :assignments


  has_one_attached :file

  #validations
  validates_date :due_date, on_or_before: :today

  #Scope
  scope :for_parent, ->(parent) { where(user_id: parent.id) }
end



class Submission < ApplicationRecord
  belongs_to :assignment
  has_one :parent, through: :assignment
  has_one :item, through: :assignment
  has_one_attached :file
  after_create :mark_assignment_complete

  scope :chronological, -> { order(date_completed: :desc) }

  #validations
  validates_date :date_completed

  #Scope
  scope :for_parent, ->(parent) { where(user_id: parent.id) }


  private
  def mark_assignment_complete
    assignment.update(completion: true)
  end
end



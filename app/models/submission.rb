class Submission < ApplicationRecord
  belongs_to :assignment
  has_one :parent, through: :assignment
  has_one :item, through: :assignment
  has_one_attached :file
  after_create :mark_assignment_complete
  after_destroy :mark_assignment_incomplete

  scope :chronological, -> { order(date_completed: :desc) }

  #validations
  validates_date :date_completed

  #Scope
  scope :for_parent, ->(parent_id) { where(parent_id: parent_id) }


  private
  def mark_assignment_complete
    assignment.update(completion: true)
  end

  def mark_assignment_incomplete
    assignment.update(completion: false)
  end
end



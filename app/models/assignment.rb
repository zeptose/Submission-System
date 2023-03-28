class Assignment < ApplicationRecord
  belongs_to :item
  belongs_to :foster_parent
  belongs_to :case_worker
  has_one :submission

  # Scopes
  scope :chronological, -> { order(due_date: :desc) }
  scope :incomplete,     -> { where(completion: false) }

  #Validations
  validates_date :due_date, after: :today


end

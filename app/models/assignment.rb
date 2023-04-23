class Assignment < ApplicationRecord
  belongs_to :item
  belongs_to :parent
  has_one :submission

  # Scopes
  scope :chronological, -> { order(due_date: :desc) }
  scope :incomplete,     -> { where(completion: false) }
  scope :complete, -> { where(completion: true) }
  scope :for_parent, ->(parent_id) { where(parent_id: parent_id) }

  #Validations
  validates_date :due_date, after: :today
  validate :single_incomplete_assignment_allowed
  validate :parent_item_is_active_in_the_system, on: :create

  #Method
  def parent_item_is_active_in_the_system
    is_active_in_system(:category)
    is_active_in_system(:item)
  end

  def single_incomplete_assignment_allowed
    if completion == false
      incomplete_assignments = Assignment.where(parent: parent, item: item, completion: false)
      if incomplete_assignments.exists? && (new_record? || incomplete_assignments.where.not(id: id).exists?)
        errors.add(:base, "Only one incomplete assignment is allowed for the same parent and item")
      end
    end
  end

  def updatestatus 
    due_date = self.due_date.to_datetime
    x = -1 * (((Date.today)- due_date).to_i)
      if due_date < Date.today 
        self.status = "Overdue"
        # self.save!
      
      elsif x < 7
        self.status = "Due in #{x} day(s)"
      
      else 
        xweeks = x/7
        xweeks = xweeks.floor()
        self.status = "Due in #{xweeks} week(s)"
    
      end 
  
  end

end

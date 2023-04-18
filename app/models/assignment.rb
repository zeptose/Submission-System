class Assignment < ApplicationRecord
  belongs_to :item
  belongs_to :parent
  has_one :submission

  # Scopes
  scope :chronological, -> { order(due_date: :desc) }
  scope :incomplete,     -> { where(completion: false) }
  scope :complete, -> { where(completion: true) }
  scope :for_parent, ->(parent) { where(user_id: parent.id) }

  #Validations
  validates_date :due_date, after: :today


  #Method
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

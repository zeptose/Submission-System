class Assignment < ApplicationRecord
  belongs_to :item
  belongs_to :parent
  belongs_to :case_worker
  has_one :submission

  # Scopes
  scope :chronological, -> { order(due_date: :desc) }
  scope :incomplete,     -> { where(completion: false) }
  scope :complete, -> { where(completion: true) }

  #Validations
  validates_date :due_date, after: :today


  #Method
  def updatestatus 
      if self.due_date > Date.today 
        self.status = "Overdue"
        self.assignment.save
      end 

      if ((Date.today + 1.week).to_i - self.due_date.to_i)/86400 > 7 
        x = ((Date.today + 1.week).to_i - self.due_date.to_i)/86400
        self.status = "Due in {x} day(s)"
      end 

      if ((Date.today + 1.week).to_i - self.due_date.to_i)/86400 <= 7 
        x = ((Date.today + 1.week).to_i - self.due_date.to_i) / 86400
        xweeks = floor(x / 7)
        self.status = "Due in {xweeks} week(s)"
      end 
  
  end

end

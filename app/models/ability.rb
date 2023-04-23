class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    ## Case Worker
    if user.role? :case_worker
      # they get to do it all
      can :manage, :all

    ## Foster parent
    elsif user.role? :parent
      # foster parents can show and index categories
      can :index, Category
      can :show, Category

      # foster parents can show individual items (index does not exist for items)
      can :show, Item
      
      # they can read and update their own profile
      # can :show, Customer, user_id: user.id  # new, more compact method
      can :show, Parent do |c|  
        c.id == user.parent.id
      end

      can :show, User do |u|  
        u.id == user.id
      end

      # show updates
      can :update, Parent do |c|  
        c.id == user.parent.id
      end

      can :update, User do |u|  
        u.id == user.id
      end
      
      # they can see if an assignment belongs to them
      can :show, Assignment do |this_assignment|
        my_assignments = user.parent.assignments.map(&:id) 
        my_assignments.include? this_assignment.id
      end

      can :index, Assignment # controller to filter assignments to just foster parent

      can :index, Submission  # controller to filter submissions to just foster parent
      can :create, Submission  # whole point is to let customers submit files...
      
      can :show, Submission do |this_submission|
        my_submissions = user.parent.assignments.map(&:submission).compact
        my_submissions.include? this_submission.id
      end

      can :show, Submission
      can :update, Submission
      can :destroy, Submission

    else # Guest account

      can :create, Parent

    end
  end
end
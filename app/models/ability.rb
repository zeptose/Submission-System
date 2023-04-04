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
      # can :show, Assignment, fosterparent.id: user.customer.id
      

      # can :show, Assignment do |this_assignment|
      #   my_assignments = user.fosterparent.assignments.map(&:id) 
      #   my_assignments.include? this_assignment.id
      # end

      # can :index, Assignment # controller to filter assignments to just customer

      # can :index, Submissions  # controller to filter submissions to just customer
      # can :create, Submissions  # whole point is to let customers submit files...

    else # Guest account

      can :create, Parent

    end
  end
end
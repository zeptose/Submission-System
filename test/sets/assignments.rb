module Contexts
    module Assignments
      # Context for both vet and assistant users
      def create_assignments
        @jordan_a1 = FactoryBot.create(:assignment, item: @PlacementRecord_i, parent: @f_jordan, 
        case_worker: @c_alex, due_date: "05/17/2023", completion: true)
        @becca_a1 = FactoryBot.create(:assignment, item: @TrainingLogs, parent: @f_becca, 
        case_worker: @c_rachel, due_date: "06/17/2023", completion: true)
        @connor_a1 = FactoryBot.create(:assignment, item: @PlacementRecord_i, parent: @f_connor, 
        case_worker: @c_mark, due_date: "08/17/2023", completion: false)
      end
      
      def destroy_assignments
        @jordan_a1.delete
        @becca_a1.delete
        @connor_a1.delete
      end

  
      def create_admin_users
        @alex = FactoryBot.create(:user, username: "alex", role: "case_worker", active: true)
        @rachel = FactoryBot.create(:user, username: "rachel", role: "case_worker", active: true)
        @mark = FactoryBot.create(:user, username: "mark", role: "case_worker", active: true)
      end
  
      def destroy_admin_users
        @alex.delete 
        @rachel.delete 
        @mark.delete
      end
  
    end
  end
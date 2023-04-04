module Contexts
    module Users
      # Context for both vet and assistant users
      def create_foster_parent_users
        @jordan = FactoryBot.create(:user, username: "jordan", role: "parent", active: true)
        @becca  = FactoryBot.create(:user, username: "becca", role: "parent", active: true)
        @connor = FactoryBot.create(:user, username: "connor", role: "parent", active: false)
      end
      
      def destroy_foster_parent_users
        @jordan.delete
        @becca.delete
        @connor.delete
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
module Contexts
    module Parents
      # Context for customers (assumes user context)
      def create_parents
        #naming f for foster parents as abbreviation
        @f_jordan = FactoryBot.create(:parent, user: @jordan, p1_first_name: "Jordan",
        p1_last_name: "Egan", email: "jordan@gmail.com",
        phone_number: "412-268-8211", open_beds = 2, family_style = "Traditional")

        @f_becca = FactoryBot.create(:parent, user: @becca, p1_first_name: "Becca", 
        p1_last_name: "Freeman", email: "beckyg@aol.com",
        phone_number: "212-306-3000", open_beds = 3, family_style = "Therapeutic")
        @f_connor = FactoryBot.create(:parent, user: @connor, p1_first_name: "Connor", 
        p1_last_name: "Corletti", email: "connor@cmu.edu", 
        phone_number: "412-268-2323", active: false, open_beds = 1, family_style = "Respite")
      end
      
      def destroy_parents
        @f_jordan.delete
        @f_becca.delete
        @f_connor.delete
      end
  
    end
  end


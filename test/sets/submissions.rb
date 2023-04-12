module Contexts
    module Users
      # Context for both vet and assistant users
      def create_submissions
        @PlacementRecord_sub = FactoryBot.create(:submission, date_completed: "4/3/2022", file: "xfile")
        @TrainingLogs_sub  = FactoryBot.create(:submission, date_completed: "3/3/2022", file: "yfile")
      end
      
      def destroy_submissions
        @jordan.delete
        @becca.delete
        @connor.delete
      end
  
    end
  end
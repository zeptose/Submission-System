module Contexts
    module Submissions
      def create_submissions
        @PlacementRecord_sub = FactoryBot.create(:submission, date_completed: "4/3/2022", 
        item: @PlacementRecord_i, file: "afile")
        @TrainingLogs_sub  = FactoryBot.create(:submission, date_completed: "3/3/2022", 
        item: @TrainingLogs, file: "bfile")
      end
      
      def destroy_submissions
        @PlacementRecord_sub.delete
        @TrainingLogs_sub.delete
      end
  
    end
  end
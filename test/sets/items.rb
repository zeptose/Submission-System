module Contexts
    module Items
        def create_items
            @Application = FactoryBot.create(:item, name: "Application", active: false, 
                category: @InitialPaperwork)

            # @InformationalInterview = FactoryBot.create(
            #     :item, 
            #     name: "Informational Interview",
            #     instructions: "Please wait until we contact you for interview details.",
            #     due_date: "Due in 3 months after registration.", 
            #     active: true,
            #     category: @InitialPaperwork)

            # placement record i stands for the item part
            # placement record c stands for the item category
            @PlacementRecord_i = FactoryBot.create(
                :item, 
                name: "Placement Record", 
                instructions: "Please submit immediately.",
                due_date: "Immediately ASAP.",
                active: true, 
                category: @PlacementRecord_c)

            @TrainingLogs = FactoryBot.create(
                :item, 
                name: "Training Log",
                category: @Certification)
        end

        def destroy_items
            @Application.delete
            # @InformationalInterview.delete
            @PlacementRecord_i.delete
            @TrainingLogs.delete

        end
    end
end
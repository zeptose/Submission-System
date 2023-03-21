module Contexts
    module Categories
        def create_categories
            @PlacementRecord_c = FactoryBot.create(:category, name: "Placement Record", active: true)
            # initial paperwork is not active, active: false
            @InitialPaperwork = FactoryBot.create(:category) 
            @Certification = FactoryBot.create(:category, name: "Certification Section", active: true)
        end

        def destroy_categories
            @PlacementRecord_c.delete
            @InitialPaperwork.delete
            @Certification.delete
        end
    end
end
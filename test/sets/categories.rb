module Contexts
    module Categories
        def create_categories
            @PlacementRecord_c = FactoryBot.create(:category, name: "Placement Record")
            # initial paperwork is not active, active: false
            @InitialPaperwork = FactoryBot.create(:category, active: false) 
            @Certification = FactoryBot.create(:category, name: "Certification Section")
        end

        def destroy_categories
            @PlacementRecord_c.delete
            @InitialPaperwork.delete
            @Certification.delete
        end
    end
end
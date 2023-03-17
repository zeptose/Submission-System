module Contexts
    module Categories
        def create_categories
            @PlacementRecord_c = FactoryBot.create(:category, name: "Placement Record", active: true)
            @InitialPaperwork = FactoryBot.create(:category, active: true)
            @Certification = FactoryBot.create(:category, name: "Certification Section")
        end

        def destroy_categories
            @PlacementRecord_c.delete
            @InitialPaperwork.delete
            @Certification.delete
        end
    end
end
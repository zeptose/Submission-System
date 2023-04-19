module Contexts
    module CaseWorker
        def create_caseworkers
            @c_alex = FactoryBot.create(:case_worker, user: @alex, first_name: "Alex",
            last_name: "Gibson", email: alex888@aol.com, phone_number: "718-371-9252" )

            @c_rachel = FactoryBot.create(:case_worker, user: @rachel, first_name: "Rachel",
            last_name: "Heart", email: rachel17@gmail.com, phone_number: "929-435-8390" )

            @c_mark = FactoryBot.create(:case_worker, user: @mark, first_name: "Mark",
            last_name: "Keith", email: mk420@yahoo.com, phone_number: "123-456-789" )

            @c_admin = FactoryBot.create(:case_worker, user: @admin, first_name: "Trisha",
            last_name: "Paytas", email: trishlikefish@yahoo.com, phone_number: "666-666-666" )
        end

        def destroy_caseworkers
            @c_alex.delete
            @c_rachel.delete
            @c_mark.delete
            @c_admin.delete
          end
      
        end
      end
    
    
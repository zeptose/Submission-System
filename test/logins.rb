module Logins 
    def login_admin
      @admin_user = FactoryBot.create(:user, username: "admin", role: "admin")
      get login_path
      post sessions_path, params: { username: "admin", password: "secret" }
    end
  
    def login_shipper
      @shipper53_user = FactoryBot.create(:user, username: "shipper53", role: "shipper")
      get login_path
      post sessions_path, params: { username: "shipper53", password: "secret" }
    end
  
    def login_customer
      @blake_user = FactoryBot.create(:user, username: "jblake", role: "customer")
      @jblake   = FactoryBot.create(:customer, user: @blake_user, first_name: "John", last_name: "Blake")
      get login_path
      post sessions_path, params: { username: "jblake", password: "secret" }
    end
  
    def logout_user
      get logout_path
      post sessions_path, params: { username: "admin", password: "secret" }
    end
  end
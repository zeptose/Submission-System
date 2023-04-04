module Logins 
    def login_case_worker
      @case_worker_user = FactoryBot.create(:user, username: "case_worker", role: "case_worker")
      get login_path
      post sessions_path, params: { username: "admin", password: "secret" }
    end
  
    def login_parent
      @parent_user = FactoryBot.create(:user, username: "parent", role: "parent")
      get login_path
      post sessions_path, params: { username: "parent", password: "secret" }
    end
  
    # def login_customer
    #   @blake_user = FactoryBot.create(:user, username: "jblake", role: "customer")
    #   @jblake   = FactoryBot.create(:customer, user: @blake_user, first_name: "John", last_name: "Blake")
    #   get login_path
    #   post sessions_path, params: { username: "jblake", password: "secret" }
    # end
  
    def logout_user
      get logout_path
      post sessions_path, params: { username: "admin", password: "secret" }
    end
  end
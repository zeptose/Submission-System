module Logins 
  def login_case_worker
    @case_worker_user = FactoryBot.create(:user, username: "admin", role: "case_worker")
    @case_worker = FactoryBot.create(:case_worker, user: @case_worker_user, first_name: "john", last_name: "wick", phone_number: "123-123-1233", email: "test@gmail.com")
    get login_path
    post sessions_path, params: { username: "admin", password: "secret" }
  end

  def logout_case_worker
    get logout_path
  end

  def login_parent
    @parent_user = FactoryBot.create(:user, username: "parent", role: "parent")
    @parent = FactoryBot.create(:parent, user: @parent_user, p1_first_name: "bob", p1_last_name: "tim",
     p2_first_name: "alex", p2_last_name: "ma", phone_number: "123-123-1233", email: "test@gmail.com", 
     active: true, open_beds: 3, family_style: "traditional")
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
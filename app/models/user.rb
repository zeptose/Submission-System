class User < ApplicationRecord
    # Modules to help with some functionality
    include AppHelpers::Deletions
    include AppHelpers::Activeable::InstanceMethods
    extend AppHelpers::Activeable::ClassMethods
  
    # Use built-in rails support for password protection
    has_secure_password
    has_many :index_fosters 
    has_many :case_workers
  
    # Scopes
    scope :by_role,      -> { order(:role) }
    scope :alphabetical, -> { order(:username) }
  
    # Validations
    validates :username, presence: true, uniqueness: { case_sensitive: false}
    validates :role, inclusion: { in: %w[case_worker foster_parent], message: "is not a recognized role in system" }
    validates_presence_of :password, on: :create 
    validates_presence_of :password_confirmation, on: :create 
    validates_confirmation_of :password, on: :create, message: "does not match"
    validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true
  
    # For use in authorizing with CanCan
    ROLES = [['Case Worker', :case_worker],['Foster Parent', :foster_parent]]
  
    def role?(authorized_role)
      return false if role.nil?
      role.downcase.to_sym == authorized_role
    end

    def self.authenticate(username, password)
      find_by_username(username).try(:authenticate, password)
    end 
  
    # Callbacks
    before_destroy :cannot_destroy_object
end

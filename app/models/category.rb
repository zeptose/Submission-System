class Category < ApplicationRecord
    include AppHelpers::Deletions
    include AppHelpers::Activeable::InstanceMethods
    extend AppHelpers::Activeable::ClassMethods

    # Relationships
    has_many :items

    # Scopes
    scope :alphabetical,  -> { order(:name) }

    # Validations
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    
    # Callbacks
    before_destroy :cannot_destroy_object

end

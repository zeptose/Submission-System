class Category < ApplicationRecord
    include AppHelpers::Activeable::InstanceMethods
    extend AppHelpers::Activeable::ClassMethods
    include AppHelpers::Deletions
    
    # Relationships
    has_many :items

    # Scopes
    scope :alphabetical,  -> { order(:name) }

    # Validations
    validates :name, presence: true, uniqueness: { case_sensitive: false }

    # Callbacks
    before_destroy :cannot_destroy_object

end

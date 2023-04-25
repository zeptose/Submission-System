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
    before_destroy do
        check_if_categories_have_items
        # if errors.present?
        #   @destroyable = false
        #   throw(:abort)
        # end
    end

    after_update :inactive_categories_have_inactive_items

    private
    def inactive_categories_have_inactive_items
        return true if self.active

        for item in self.items do
            item.make_inactive
        end
    end

    def check_if_categories_have_items
        unless self.items.empty?
            errors.add(:base, "This categories have current items associated, and therefore cannot be deleted.")
        end
    end

end

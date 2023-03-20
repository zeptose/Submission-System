class Item < ApplicationRecord
  # Modules to help with some functionality
  include AppHelpers::Validations
  include AppHelpers::Activeable::InstanceMethods
  extend AppHelpers::Activeable::ClassMethods


    belongs_to :category

  # Scopes
  scope :alphabetical, -> { order(:name) }
  scope :for_category, ->(category) { where(category_id: category.id) }
  scope :search,       ->(term) { where('name LIKE ? OR description LIKE ?', "%#{term}%", "%#{term}%") }


  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validate :category_is_active_in_the_system, on: :create

  # Callbacks
  before_destroy :cannot_destroy_object

  private
    def category_is_active_in_the_system
      is_active_in_system(:category)
    end

end

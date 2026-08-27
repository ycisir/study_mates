require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    activated: Field::Boolean,
    activated_at: Field::DateTime,
    activation_digest: Field::String,
    active_relationships: Field::HasMany,
    admin: Field::Boolean,
    avatar: Field::ActiveStorage,
    email: Field::String,
    followers: Field::HasMany,
    following: Field::HasMany,
    joined_rooms: Field::HasMany,
    messages: Field::HasMany,
    name: Field::String,
    passive_relationships: Field::HasMany,
    password_digest: Field::String,
    remember_digest: Field::String,
    reset_digest: Field::String,
    reset_sent_at: Field::DateTime,
    rooms: Field::HasMany,
    slug: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    password: Field::Password
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    email
    activated
    admin
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    activated
    activated_at
    active_relationships
    admin
    avatar
    email
    followers
    following
    joined_rooms
    messages
    name
    passive_relationships
    rooms
    slug
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    activated
    activated_at
    admin
    avatar
    email
    name
    password
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    user.name
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true
  has_one_attached :avatar
  has_many :rooms, dependent: :destroy
  enum :role, { member: 0, admin: 1 }

  validate :avatar_validation

  def avatar_thumbnail
    avatar.variant(resize_to_fill: [150, 150]).processed if avatar.attached?
  end

  private

  def avatar_validation
    return unless avatar.attached?

    # Validate file type
    unless avatar.content_type.in?(%w[image/png image/jpeg image/jpg])
      errors.add(:avatar, "must be a PNG or JPG")
    end

    # Validate file size (max 2MB)
    if avatar.blob.byte_size > 2.megabytes
      errors.add(:avatar, "is too big (max 2MB)")
    end
  end
end

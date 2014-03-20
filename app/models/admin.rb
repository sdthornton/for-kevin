class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :lockable

  before_validation :encrypt_invite_code
  after_validation :clear_invite_code

  validates :name, :invite_code, presence: true
  validates :first_name, absence: true

  validate :validate_invite_code, on: :create

  def encrypt_invite_code
    self.invite_code = self.invite_code.crypt(ENV['ADMIN_INVITE_SALT']) if self.invite_code.present?
  end

  def validate_invite_code
    unless self.invite_code == ENV['ADMIN_INVITE_CODE']
      errors.add(:invite_code, "Please enter a valid invite code")
    end
  end

  def clear_invite_code
    self.invite_code = nil unless self.errors.empty?
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, absence: false
  validates :name, presence: true
  validates :email, exclusion: { in: %w(curtismichael@email.arizona.edu),
            message: "This user is not allowed" }

  has_many :bids, dependent: :destroy, inverse_of: :user
end

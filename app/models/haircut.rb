class Haircut < ActiveRecord::Base
  validates :member, :about, :url, presence: true
  validates :member, :url, uniqueness: true

  has_many :bids, dependent: :destroy, inverse_of: :haircut

  before_validation :build_url

  has_attached_file :photo,
    styles: {
      retina: {
        geometry: "728x484#"
      },
      normal: {
        geometry: "364x242#"
      }
    },
    default_url: "/assets/missing.jpg"

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def build_url
    self.url = self.member.parameterize.underscore.to_s unless self.member.blank?
  end

  def self.search(query)
    where("member LIKE ?", "%#{query}%")
  end

  def self.filter(letter)
    where("member LIKE ?", "#{letter}%")
  end

  def self.random(n)
    ids = Haircut.pluck(:id).sample(n)
    Haircut.where(id: ids)
  end
end

class Haircut < ActiveRecord::Base
  validates :member, :about, :url, presence: true
  validates :member, :url, uniqueness: true

  has_many :bids, dependent: :destroy, inverse_of: :haircut

  before_validation :build_url

  has_attached_file :photo,
    styles: {
      retina: "",
      normal: ""
    },
    convert_options: {
      retina: "-gravity north -thumbnail 768x512^ -extent 768x512",
      normal: "-gravity north -thumbnail 384x256^ -extent 384x256"
    },
    default_url: "/assets/no_photo.jpg"

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  crop_attached_file :photo, aspect: "3:2"

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
    primary_ids = Haircut.where(primary: true).pluck(:id).sample(n)
    other_ids = Haircut.where(primary: false).pluck(:id).sample(n - primary_ids.count) if primary_ids.count < n
    ids = primary_ids << other_ids
    Haircut.where(id: ids).order(primary: :desc)
  end

  def self.ordered
    Haircut.order(primary: :desc, member: :asc)
  end

  def self.winners
    winner_ids = []
    Haircut.find_each do |haircut|
      winner_ids.push(haircut.bids.order('amount DESC').first.user.id) unless haircut.bids.empty?
    end
    User.where(id: winner_ids)
  end
end

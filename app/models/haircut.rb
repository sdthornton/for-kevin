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
    url: "/assets/haircuts/:id/:style/:basename.:extension",
    path: ":rails_root/public/assets/haircuts/:id/:style/:basename.:extension",
    default_url: "/assets/no_photo.jpg"

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  crop_attached_file :photo, aspect: "3:2"

  before_save :set_primary_image_color

  def build_url
    self.url = self.member.parameterize.underscore.to_s unless self.member.blank?
  end

  def set_primary_image_color
    if (changed & ["photo_updated_at"]).any? && self.photo.queued_for_write[:original].present?
      image = File.new self.photo.queued_for_write[:original].path
      colors = Miro::DominantColors.new(image)
      min = colors.by_percentage.each_with_index.max[1]
      hex_color = colors.to_hex[min]
      self.primary_image_color = hex_color
    end
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
    ids = primary_ids.push(other_ids).flatten
    Haircut.where(id: ids).order(primary: :desc)
  end

  def self.ordered
    Haircut.order(primary: :desc, member: :asc)
  end

  def self.ordered_ids
    Hash[Haircut.ordered.pluck(:id).map.with_index.to_a]
  end

  def self.winners
    winning_bids = []
    Haircut.find_each do |haircut|
      winning_bids.push(haircut.bids.order('amount DESC').first.id) unless haircut.bids.empty?
    end
    Bid.where(id: [winning_bids])
  end
end

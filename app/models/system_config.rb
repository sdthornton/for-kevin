class SystemConfig < ActiveRecord::Base
  acts_as_singleton
  self.table_name = "system_config"

  def self.close_bidding_at
    if instance.close_bidding_at.present?
      date = instance.close_bidding_at
      Time.zone.local(date.year, date.month, date.day)
    else
      Time.zone.now
    end
  end

  def self.current_bidding_year
    instance.current_bidding_year || 2014
  end
end

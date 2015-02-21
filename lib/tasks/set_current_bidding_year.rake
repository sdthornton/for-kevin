task :set_current_bidding_year, [:year] => :environment do |t, args|
  @year = args[:year].to_i

  Bid.where(bidding_year: nil).each do |bid|
    bid.bidding_year = @year - 1
    bid.save!
  end

  @config = SystemConfig.instance
  @config.current_bidding_year = @year
  @config.save!
end

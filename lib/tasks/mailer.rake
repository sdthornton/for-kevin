namespace :mailer do
  task last_day_to_bid: :environment do
    User.find_each do |user|
      UserMailer.last_day_to_bid(user).deliver
    end
  end

  task demo_last_day_to_bid: :environment do
    @demo_users = User.where(email: ['sdthornton@live.com', 'sam.david.thornton@gmail.com'])
    @demo_users.each do |user|
      UserMailer.last_day_to_bid(user).deliver
    end
  end
end

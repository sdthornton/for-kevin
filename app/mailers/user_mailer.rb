class UserMailer < ActionMailer::Base
  default from: "reminder@example.com"

  def last_day_to_bid(user)
    @user = user
    mail(to: @user.email, from: 'admin@azcutthechi.com',
        subject: 'Only One More Day to Bid!')
  end
end

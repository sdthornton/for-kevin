class UserMailer < ActionMailer::Base
  default from: "reminder@example.com"

  def last_day_to_bid(user)
    @user = user
    email_with_name = "#{@user.name} <#{@user.email}>"
    from_with_name = "Cut the Chi <reminder@azcutthechi.com>"
    delivery_options = {
      user_name: ENV['USER_MAILER_USER'],
      password: ENV['USER_MAILER_PASS']
    }
    mail(to: email_with_name, from: from_with_name,
        delivery_method_options: delivery_options,
        subject: 'Only One More Day to Bid!')
  end
end

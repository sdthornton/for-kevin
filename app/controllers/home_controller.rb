class HomeController < ApplicationController
  def authenticate_session!(opts = {})
    if admin_signed_in?
      authenticate_admin!
    else
      authenticate_user!
    end
  end

  before_filter :authenticate_session!, only: [:bids]
  before_filter :authenticate_admin!, only: [:users]

  def index
    @haircuts = Haircut.random(4)
  end

  def about
  end

  def bids
    @haircuts = Haircut.order('member ASC') if admin_signed_in?
    @bids = current_user.bids.order('amount DESC') if user_signed_in?
  end

  def users
    @users = User.order('name ASC')
  end
end

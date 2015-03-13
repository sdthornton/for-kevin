class HomeController < ApplicationController
  etag do
    {
      current_user_id: current_user.present? && current_user.id,
      current_admin_id: current_admin.present? && current_admin.id
    }
  end

  before_filter :authenticate_admin!, only: [:bids, :users, :delete_user]
  before_filter :authenticate_user!, only: [:user_bids]

  def index
    @haircuts = Haircut.random(4)

    fresh_when([Haircut.count, @haircuts.maximum(:updated_at)])
  end

  def about
    fresh_when(SystemConfig.close_bidding_at)
  end

  def user_bids
    @bids = current_user.bids.joins(:haircut)
      .where('bids.amount = (SELECT MAX(bids.amount) FROM bids WHERE bids.haircut_id = haircuts.id)')

    fresh_when(@bids.count)
  end

  def bids
    @haircuts = Haircut.includes(:bids).order('member ASC')

    fresh_when([Haircut.count, @haircuts.maximum(:updated_at)])
  end

  def users
    @users = User.includes(:bids).order('name ASC')

    fresh_when([User.count, @users.maximum(:updated_at)])
  end

  def delete_user
    @user = User.find(params[:id])
    @user.destroy
    redirect_to show_users_path, turbolinks: true
  end
end

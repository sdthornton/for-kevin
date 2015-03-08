class HomeController < ApplicationController
  before_filter :authenticate_admin!, only: [:bids, :users, :delete_user]
  before_filter :authenticate_user!, only: [:user_bids]
  before_filter :set_system_config

  def index
    @haircuts = Haircut.includes(:bids).random(4)
  end

  def about
  end

  def user_bids
    @bids = current_user.bids.order('amount DESC')
  end

  def bids
    @haircuts = Haircut.includes(:bids).order('member ASC')
  end

  def users
    @users = User.includes(:bids).order('name ASC')
  end

  def delete_user
    @user = User.find(params[:id])
    @user.destroy
    redirect_to show_users_path, turbolinks: true
  end
end

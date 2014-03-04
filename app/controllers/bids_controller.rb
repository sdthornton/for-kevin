class BidsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bids = Bid.all
  end

  def create
    @haircut = Haircut.find(params[:haircut_id])
    @user = current_user
    @bid = @haircut.bids.create(bid_params.merge(user_id: @user.id))
    redirect_to show_haircut_path(@haircut.url)
  end

  def show
  end

  def destroy
  end


  private
    def bid_params
      params[:bid].permit(:amount)
    end

end

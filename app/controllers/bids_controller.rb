class BidsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]
  before_filter :authenticate_admin!, only: [:destroy]

  def create
    @haircut = Haircut.includes(:bids).find(params[:haircut_id])
    @user = current_user
    @bid = @haircut.bids.new(bid_params.merge(user_id: @user.id))

    if @bid.save
      redirect_to show_haircut_path(@haircut.url), turbolinks: true,
        successful_bid:
          "Thanks for your <strong>$#{"%.2f" % @bid.amount}</strong>
          bid on <strong>#{@haircut.member}</strong>. If your bid
          wins we'll email you to let you know. Either way, show
          up #{@system_config.close_bidding_at.strftime("%B %e")}
          to the Theta Chi house for a great time!".html_safe
    else
      redirect_to show_haircut_path(@haircut.url, turbolinks: true,
        bid_errors: @bid.errors.messages[:amount])
    end
  end

  def destroy
    @bid = Bid.find(params[:id])
    @haircut = Haircut.includes(:bids).find(@bid.haircut_id)
    @bid.destroy

    redirect_to show_haircut_path(@haircut.url), turbolinks: true
  end

  def info
    respond_to :json
  end

private

  def bid_params
    params[:bid].permit(:amount)
  end

end

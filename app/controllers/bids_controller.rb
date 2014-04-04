class BidsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bids = Bid.all
  end

  def create
    @haircut = Haircut.find(params[:haircut_id])
    @user = current_user
    @bid = @haircut.bids.create(bid_params.merge(user_id: @user.id))

    if @bid.save
      redirect_to show_haircut_path(@haircut.url),
        successful_bid: "Thanks for you bid of
                        <strong>$#{"%.2f" % @bid.amount}</strong>
                        for <strong>#{@haircut.member}</strong>. If your bid
                        ends up winning you'll receive an email letting you
                        know. And either way, show up May 2nd to the Theta Chi
                        house for a wonderful, haircuttingly-good time!".html_safe
    else
      redirect_to show_haircut_path(@haircut.url,
        bid_errors: @bid.errors.messages[:amount])
    end
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

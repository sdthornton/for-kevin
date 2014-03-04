class HaircutsController < ApplicationController
  before_filter :authenticate_admin!, except: [:index, :show]

  def index
    @haircuts = Haircut.order('member ASC')
  end

  def new
    @haircut = Haircut.new
  end

  def create
    @haircut = Haircut.new(haircut_params)

    if @haircut.save
      redirect_to '/haircuts'
    else
      render 'new'
    end
  end

  def show
    @haircut = Haircut.find_by!(url: params[:url])
    @bids = @haircut.bids.order('amount ASC')
  end

  def edit
    @haircut = Haircut.find_by!(url: params[:url])
  end

  def update
    @haircut = Haircut.find(params[:id])

    if @haircut.update(haircut_params)
      redirect_to show_haircut_path(@haircut.url)
    else
      render 'edit'
    end
  end

  def destroy
    @haircut = Haircut.find(params[:id])
    @haircut.destroy

    redirect_to ''
  end


  private
    def haircut_params
      params.require(:haircut).permit(:member, :about, :photo)
    end

end

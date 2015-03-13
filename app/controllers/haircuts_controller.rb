class HaircutsController < ApplicationController
  etag do
    {
      current_user_id: current_user.present? && current_user.id,
      current_admin_id: current_admin.present? && current_admin.id
    }
  end

  PER_PAGE = 20

  before_filter :authenticate_admin!, except: [:index, :show]

  def index
    @search = params[:query] || params[:letter] || false
    @page = params[:page]
    @url = params[:url]
    haircuts = Haircut.includes(:bids)

    if params[:query]
      @haircuts = haircuts.search(params[:query])
    elsif params[:letter]
      @haircuts = haircuts.filter(params[:letter]).order('member ASC')
    else
      @haircuts = haircuts.ordered.page(@page).per(PER_PAGE)
    end

    fresh_when([Haircut.count, @haircuts.maximum(:updated_at)])
  end

  def new
    @haircut = Haircut.new
  end

  def create
    @haircut = Haircut.new(haircut_params)

    if @haircut.save
      redirect_to show_haircut_path(@haircut.url), turbolinks: true
    else
      render 'new'
    end
  end

  def show
    haircuts = Haircut.includes(:bids)
    @haircut = haircuts.find_by!(url: params[:url])
    @bids = @haircut.bids.order('amount DESC')

    if admin_signed_in?
      respond_to :html, :json
    elsif user_signed_in?
      respond_to do |format|
        format.html {
          page = haircut_page(@haircut.id)
          @haircuts = haircuts.ordered.page(page).per(PER_PAGE)
          render :index, params: { page: page }
        }
        format.json
      end
    else
      respond_to do |format|
        format.html { redirect_to login_path, turbolinks: true }
        format.json
      end
    end

    fresh_when(@haircut.updated_at)
  end

  def edit
    @haircut = Haircut.find_by!(url: params[:url])

    fresh_when(@haircut.updated_at)
  end

  def update
    @haircut = Haircut.find(params[:id])

    if @haircut.update(haircut_params)
      redirect_to show_haircut_path(@haircut.url), turbolinks: true
    else
      render 'edit'
    end
  end

  def destroy
    @haircut = Haircut.find(params[:id])
    @haircut.destroy

    redirect_to '/haircuts', turbolinks: true
  end

private

  def haircut_params
    params.require(:haircut).permit(:member, :about, :photo, :primary,
      :photo_original_w, :photo_original_h, :photo_box_w, :photo_crop_x,
      :photo_crop_y, :photo_crop_w, :photo_crop_h, :photo_aspect)
  end

  def haircut_page(id)
    page = (Haircut.ordered_ids[id] / PER_PAGE) + 1
  end

end

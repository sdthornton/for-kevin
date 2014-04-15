class HaircutsController < ApplicationController
  before_filter :authenticate_admin!, except: [:index, :show]

  def index
    if params[:search]
      @haircuts = Haircut.search(params[:search]).page(params[:page]).per(20)
      @search = true
    elsif params[:letter]
      @haircuts = Haircut.filter(params[:letter]).order('member ASC')
                  .page(params[:page]).per(20)
      @search = true
    else
      @haircuts = Haircut.ordered.page(params[:page]).per(20)
      @search = false
    end
  end

  def new
    @haircut = Haircut.new
  end

  def create
    @haircut = Haircut.new(haircut_params)

    if @haircut.save
      redirect_to "/haircuts/#{@haircut.url}"
    else
      render 'new'
    end
  end

  def show
    @haircut = Haircut.find_by!(url: params[:url])
    @bids = @haircut.bids.order('amount DESC')

    if admin_signed_in?
      respond_to :html, :json
    elsif user_signed_in?
      respond_to do |format|
        format.html {
          cookies[:show_haircut] = {
            value: @haircut.url,
            path: "/"
          }
          page = (Haircut.ordered.pluck('member').index(@haircut.member) / 20) + 1
          redirect_to haircuts_path(page: page)
        }
        format.json
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path }
        format.json
      end
    end
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

    redirect_to '/haircuts'
  end


  private
    def haircut_params
      params.require(:haircut).permit(:member, :about, :photo, :primary,
        :photo_original_w, :photo_original_h, :photo_box_w, :photo_crop_x,
        :photo_crop_y, :photo_crop_w, :photo_crop_h, :photo_aspect)
    end

end

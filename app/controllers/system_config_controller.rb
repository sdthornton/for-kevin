class SystemConfigController < ApplicationController
  before_filter :authenticate_admin!, except: [:index, :show]
  before_filter :set_system_config

  def edit
  end

  def update
    if @system_config.update_attributes(system_config_params)
      flash[:notice] = "Successfully updated system configuration."
      redirect_to edit_system_config_path
    else
      flash[:alert] = "There was an error updating the system configuration."
      render :edit
    end
  end

  private
    def system_config_params
      params.require(:system_config).permit(:close_bidding_at)
    end
end

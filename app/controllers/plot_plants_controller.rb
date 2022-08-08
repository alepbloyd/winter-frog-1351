class PlotPlantsController < ApplicationController

  def destroy

    plot_plant = PlotPlant.where(plot_id: plot_plants_params[:plot_id], plant_id: plot_plants_params[:plant_id])[0]

    plot_plant.destroy

    redirect_to plots_path
  end

  private
  def plot_plants_params
    params.permit(:plot_id, :plant_id)
  end

end
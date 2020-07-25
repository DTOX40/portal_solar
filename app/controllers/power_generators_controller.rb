class PowerGeneratorsController < ApplicationController
  before_action :recomeda_params, only: [:recommenda]

  def index
    @power_generators = PowerGenerator.all
  end

  def recommenda
    @power_generators = PowerGenerator.recommenda(@manufacturer, @structure_type)
      if @power_generators.empty?
    end

    render :index
  end

  private

  def recomeda_params
    manufacturer = params[:manufacturer]
    structure_type = params[:structure_type]

    @manufacturer = manufacturer unless manufacturer.empty?
    @structure_type = structure_type unless structure_type.empty?
  end

end

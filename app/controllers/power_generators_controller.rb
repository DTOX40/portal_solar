class PowerGeneratorsController < ApplicationController
  before_action :recomeda_params, only: [:recommenda]

  def index
    @power_generators = PowerGenerator.all
  end

  def show
    @power_generator = PowerGenerator.find(params[:id])
  end

  def recommenda
    @power_generators = PowerGenerator.recommenda(@manufacturer, @structure_type)
      if @power_generators.empty?
    end

    render :index
  end

  def freight_cost
    @power_generator = PowerGenerator.find(params[:id])
    @address = AddressFinder.new(params[:cep]).address
    unless @address[:erro] == true
      @cost = Freight.cost_calculate(@power_generator.weight, @address[:uf])
    end
      render :show
  end

  private

  def recomeda_params
    manufacturer = params[:manufacturer]
    structure_type = params[:structure_type]

    @manufacturer = manufacturer unless manufacturer.empty?
    @structure_type = structure_type unless structure_type.empty?
  end

end

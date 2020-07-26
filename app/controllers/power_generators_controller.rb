require 'open-uri'

class PowerGeneratorsController < ApplicationController
  before_action :recomeda_params, only: [:recommenda]

  def index
    @power_generators = PowerGenerator.all
  end

  def show
    @power_generator = PowerGenerator.find(params[:id])
    @zip = params[:zip_code]
    if @zip
      @zip_value = @zip[:code]
      url = "http://apps.widenet.com.br/busca-cep/api/cep/#{@zip_value.first(5)}-#{@zip_value.last(3)}.json"
      address = open(url).read
      @address = JSON.parse(address)

      @freights = Freight.address_state(@address)
    else
      @freights = []
    end
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

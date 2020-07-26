# require 'open-uri'

class PowerGeneratorsController < ApplicationController
  before_action :recomeda_params, only: [:recommenda]

  def index
    @power_generators = PowerGenerator.all.page(params[:page]).order(params[:options])

    @power_generators_total = @power_generators
    options = {page: params[:page] || 1, per_page: 6}
    @power_generators = @power_generators.paginate(options)
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

  def search
    @power_generators = PowerGenerator.search(params[:q]).page(params[:page])
    if @power_generators.blank?
      flash[:notice] = 'Não há nada correspondente a sua pesquisa.'
    end
    render :index
  end

  def recommenda
    @power_generators = PowerGenerator.recommenda(@price, @manufacturer, @structure_type).page(params[:page])
    if @power_generators.empty?
      flash[:notice] = 'Não há nada correspondente a sua pesquisa.'
      return render :index
    end

    render :index
  end

  private

  def recomeda_params
    manufacturer = params[:manufacturer]
    price = params[:price]
    structure_type = params[:structure_type]

    @manufacturer = manufacturer unless manufacturer.empty?
    @price = price unless price.blank?
    @structure_type = structure_type unless structure_type.empty?
  end

end

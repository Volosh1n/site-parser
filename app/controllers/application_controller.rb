class ApplicationController
  include DataExtractor

  HOST_URL = 'https://losangeles.craigslist.org'.freeze
  DEFAULT_TITLE = 'Craigslist cars and motos parsing app'.freeze

  def initialize(params)
    @params = params
  end

  def call
    return model_path_params if params['model']

    return brand_path_params if params['brand']

    root_path_params
  end

  private

  attr_reader :params

  def root_path_params
    {
      :@brands => brands.keys.sort,
      :@title => prepend_title('')
    }
  end

  def brand_path_params
    brand = params[:brand].split('%20').map(&:capitalize).join(' ')
    vehicles = Parser.new([HOST_URL, search_path, brand].join).call
    {
      :@brand => brand,
      :@title => prepend_title(brand),
      :@models => brands[brand.downcase],
      :@vehicles => vehicles
    }
  end

  def model_path_params
    model = "#{params[:brand]}+#{params[:model]}".downcase
    vehicles = Parser.new([HOST_URL, search_path, model].join).call
    title = prepend_title("#{params[:brand]} #{params[:model]}")
    { :@title => title, :@vehicles => vehicles }
  end

  def search_path
    ''
  end

  def prepend_title(page_title)
    [page_title.upcase, params['type'].capitalize, DEFAULT_TITLE].reject(&:empty?).join(' | ')
  end
end

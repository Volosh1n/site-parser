class Dispatcher
  CARS_URL = 'https://losangeles.craigslist.org/search/cto?auto_make_model='.freeze
  DEFAULT_TITLE = 'Craigslist\'s cars ads parsing app'.freeze

  def initialize(params)
    @params = params
  end

  def call
    case params.keys.size
    when 0 then root_path_params
    when 1 then brand_path_params
    when 2 then model_path_params
    end
  end

  private

  attr_reader :params

  def root_path_params
    {
      :@brands => car_brands.keys.sort,
      :@title => DEFAULT_TITLE,
      :@layout => 'cars/index'.to_sym
    }
  end

  def brand_path_params
    brand = params[:brand].split('%20').map(&:capitalize).join(' ')
    cars = CarsParser.new([CARS_URL, brand].join).call
    {
      :@brand => brand,
      :@title => prepend_title(brand),
      :@models => car_brands[brand],
      :@cars => cars
    }
  end

  def model_path_params
    model = [params[:brand], params[:model]].join('+').downcase
    cars = CarsParser.new([CARS_URL, model].join).call
    title = prepend_title("#{params[:brand].capitalize} #{params[:model].capitalize}")
    { :@title => title, :@cars => cars }
  end

  def car_brands
    @car_brands ||= DataExtractor.new('cars').call
  end

  def prepend_title(page_title)
    "#{page_title} | #{DEFAULT_TITLE}"
  end
end

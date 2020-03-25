class Dispatcher
  CARS_URL = 'https://losangeles.craigslist.org/search/cto?auto_make_model='.freeze
  DEFAULT_TITLE = 'Cars ad parsing app'.freeze

  def initialize(request_path)
    @request_path = request_path
  end

  def call
    check_path
  end

  private

  attr_reader :request_path

  def params
    car_full_name = request_path.split('/').reject(&:empty?)
    return { brand: car_full_name.first } if car_full_name.size == 1

    { brand: car_full_name.first, model: car_full_name.last }
  end

  def check_path
    case request_path.split('/').reject(&:empty?).size
    when 0 then root_path_params
    when 1 then brand_path_params
    when 2 then model_path_params
    end
  end

  def root_path_params
    {
      :@brands => car_brands.keys.sort,
      :@title => DEFAULT_TITLE,
      :@layout => 'cars/index'.to_sym
    }
  end

  def brand_path_params
    brand = params[:brand].split(' ').map(&:capitalize).join(' ')
    cars = CarsParser.new([CARS_URL, brand].join).call
    {
      :@brand => brand,
      :@title => [brand, DEFAULT_TITLE].join(' | '),
      :@models => car_brands[brand],
      :@cars => cars
    }
  end

  def model_path_params
    model = [params[:brand], params[:model]].join('+').downcase
    cars = CarsParser.new([CARS_URL, model].join).call
    {
      :@title => "#{params[:brand].capitalize} #{params[:model].capitalize} | #{DEFAULT_TITLE}",
      :@cars => cars
    }
  end

  def car_brands
    @car_brands ||= DataExtractor.new('cars').call
  end
end

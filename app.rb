class App < Sinatra::Base
  CARS_URL = 'https://losangeles.craigslist.org/search/cto?auto_make_model='.freeze
  DEFAULT_TITLE = 'Cars ad parsing app'.freeze

  set :views, settings.root + '/app/views'

  before do
    @title = DEFAULT_TITLE
  end

  get '/' do
    @brands = car_brands.keys.sort
    haml 'cars/index'.to_sym
  end

  get '/:brand' do
    @brand = params[:brand].split(' ').map(&:capitalize).join(' ')
    @title = [@brand, DEFAULT_TITLE].join(' | ')
    @models = car_brands[@brand]
    @cars = CarsParser.new([CARS_URL, @brand].join).call
    haml 'cars/show'.to_sym
  end

  get '/:brand/:model' do
    @car = [params[:brand], params[:model]].join('+').downcase
    @title = "#{params[:brand].capitalize} #{params[:model].capitalize} | #{DEFAULT_TITLE}"
    @cars = CarsParser.new([CARS_URL, @car].join).call
    haml 'cars/show'.to_sym
  end

  private

  def car_brands
    @car_brands ||= DataExtractor.new('car_brands').call
  end
end

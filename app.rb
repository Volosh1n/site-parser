class App < Sinatra::Base
  set :views, settings.root + '/app/views'

  get '/' do
    @brands = car_brands.keys.sort
    haml 'cars/index'.to_sym
  end

  get '/:brand' do
    @brand = params[:brand].split(' ').map(&:capitalize).join(' ')
    @models = car_brands[@brand]
    @cars = CarsParser.new("https://losangeles.craigslist.org/search/cto?auto_make_model=#{@brand}").call
    haml 'cars/show'.to_sym
  end

  get '/:brand/:model' do
    @car = [params[:brand], params[:model]].join('+').downcase
    @cars = CarsParser.new("https://losangeles.craigslist.org/search/cto?auto_make_model=#{@car}").call
    haml 'cars/show'.to_sym
  end

  private

  def car_brands
    @car_brands ||= DataExtractor.new('car_brands').call
  end
end

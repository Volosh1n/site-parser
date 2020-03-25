class App < Sinatra::Base
  set :views, settings.root + '/app/views'

  before do
    Dispatcher.new(request.path).call.map { |key, value| instance_variable_set(key, value) }
  end

  get '/' do
    haml 'cars/index'.to_sym
  end

  get '/:brand' do
    haml 'cars/show'.to_sym
  end

  get '/:brand/:model' do
    haml 'cars/show'.to_sym
  end
end

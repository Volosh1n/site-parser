class App < Sinatra::Base
  set :views, settings.root + '/app/views'

  get '/' do
    Dispatcher.new(params).call.map(&method(:instance_variable_set))
    haml 'cars/index'.to_sym
  end

  get '/:brand' do
    Dispatcher.new(params).call.map(&method(:instance_variable_set))
    haml 'cars/show'.to_sym
  end

  get '/:brand/:model' do
    Dispatcher.new(params).call.map(&method(:instance_variable_set))
    haml 'cars/show'.to_sym
  end
end

class App < Sinatra::Base
  set :views, settings.root + '/app/views'

  get '/' do
    @title = ApplicationController::DEFAULT_TITLE
    haml 'home'.to_sym
  end

  get '/:type' do
    variables = Object.const_get("#{params[:type].capitalize}Controller").new(params).call
    variables.map(&method(:instance_variable_set))
    haml "#{params['type']}/index".to_sym
  end

  get '/:type/:brand' do
    variables = Object.const_get("#{params[:type].capitalize}Controller").new(params).call
    variables.map(&method(:instance_variable_set))
    haml "#{params['type']}/show".to_sym
  end

  get '/:type/:brand/:model' do
    variables = Object.const_get("#{params[:type].capitalize}Controller").new(params).call
    variables.map(&method(:instance_variable_set))
    haml "#{params['type']}/show".to_sym
  end
end

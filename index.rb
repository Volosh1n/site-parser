require 'sinatra'
require './autoload.rb'

set :views, settings.root + '/app/views'

get '/' do
  erb 'cars/index'.to_sym
end

get '/:brand' do
  cars = CarsParser.call("https://losangeles.craigslist.org/search/cto?auto_make_model=#{params[:brand]}").cars_list
  erb 'cars/show'.to_sym, locals: { cars: cars }
end

get '/:brand/:model' do
  selected = [params[:brand], params[:model]].join('+')
  cars = CarsParser.call("https://losangeles.craigslist.org/search/cto?auto_make_model=#{selected}").cars_list
  erb 'cars/show'.to_sym, locals: { cars: cars }
end
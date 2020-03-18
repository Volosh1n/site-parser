require 'sinatra'
require_relative 'autoload.rb'

# TODO: refactor this...

get '/' do
  brands = ['Subaru', 'Audi', 'Volvo']
  links = brands.map do |brand|
    "<a href='/#{brand.downcase}'>#{brand}</a><br>"
  end.join
  erb links
end

get '/:brand' do
  back_button = "<a href='/'>Back</>"
  cars = CarsParser.new("https://losangeles.craigslist.org/search/cto?query=#{params[:brand]}").call
  cars_list = cars.map do |car|
    "<div><a href=#{car[:link]}>#{car[:label].split(' ').map(&:capitalize).join(' ')}</a>: <b>#{car[:price]}</b></div>"
  end.join
  erb [back_button, cars_list].join('<hr>')
end

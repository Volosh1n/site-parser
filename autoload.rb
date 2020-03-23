require 'sinatra'
require 'nokogiri'
require 'yaml'
require 'pry'
require 'open-uri'
require './app'
require 'haml'

Dir[File.join(__dir__, 'app/**/*.rb')].sort.each { |file| require file }

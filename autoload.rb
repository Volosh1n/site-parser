require 'sinatra'
require 'nokogiri'
require 'yaml'
require 'pry'
require 'open-uri'
require './app.rb'
require 'haml'
require_relative 'app/helpers/data_extractor'

Dir[File.join(__dir__, 'app/**/*.rb')].sort.each { |file| require file }

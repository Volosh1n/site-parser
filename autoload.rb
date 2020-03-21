require 'nokogiri'
require 'yaml'
require 'pry'
require 'open-uri'

Dir[File.join(__dir__, 'app/**/*.rb')].sort.each { |file| require file }

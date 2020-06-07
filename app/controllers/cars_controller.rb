class CarsController < ApplicationController
  def search_path
    '/search/cto?auto_make_model='
  end

  def brands
    @brands ||= load_data('cars')
  end
end

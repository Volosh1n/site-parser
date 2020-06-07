class MotosController < ApplicationController
  def search_path
    '/search/mcy?auto_make_model='
  end

  def brands
    @brands ||= load_data('motos')
  end
end

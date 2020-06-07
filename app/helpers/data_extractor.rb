module DataExtractor
  DATA_FOLDER_PATH = File.expand_path('../../app/data', __dir__).to_s.freeze

  def load_data(file_name)
    YAML.load_file("#{DATA_FOLDER_PATH}/#{file_name}.yml", {})
  end
end

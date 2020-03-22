class DataExtractor
  DATA_FOLDER_PATH = "#{File.expand_path("../../app/data", __dir__)}"

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    YAML.load_file("#{DATA_FOLDER_PATH}/#{file_name}.yml", {})
  end

  private

  attr_reader :file_name
end

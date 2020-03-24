RSpec.describe DataExtractor do
  subject(:service) { described_class.new(file_name) }

  let(:file_name) { 'cars' }

  describe '#initialize' do
    it 'initializes name of file to be parsed' do
      expect(service.instance_variable_get(:@file_name)).to eq(file_name)
    end
  end

  describe '#call' do
    it 'returns values from file as hash through YAML' do
      expect(YAML).to receive(:load)
      service.call
    end
  end
end

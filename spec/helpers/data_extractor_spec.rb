RSpec.describe DataExtractor do
  let(:file_name) { 'cars' }

  describe '#load_data' do
    it 'returns values from file as hash through YAML' do
      dc = Class.new
      dc.extend(described_class)
      expect(YAML).to receive(:load)
      dc.load_data(file_name)
    end
  end
end

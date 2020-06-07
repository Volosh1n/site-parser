RSpec.describe Parser do
  subject(:service) { described_class.new(link) }

  let(:link) { File.expand_path('../fixtures/page.html', __dir__) }

  describe '#initialize' do
    it 'initializes link to be parsed' do
      expect(service.instance_variable_get(:@link)).to eq(link)
    end
  end

  describe '#call' do
    it 'returns array of hashes' do
      expect(service.call).to be_a(Array)
      expect(service.call).to be_all(Hash)
    end

    it 'hashes matches expected keys' do
      %i[label price link].each do |key|
        expect(service.call.first).to have_key(key)
      end
    end
  end
end

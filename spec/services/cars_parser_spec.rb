RSpec.describe CarsParser do
  subject(:service) { described_class.new(link) }

  let(:link) { File.expand_path('../fixtures/page.html', __dir__) }

  describe '#call' do
    it 'returns array of hashes' do
      expect(service.call).to be_a(Array)
      expect(service.call.all?(Hash)).to be_truthy
    end

    it 'hashes matches expected keys' do
      %i[label price link].each do |key|
        expect(service.call.first).to have_key(key)
      end
    end
  end
end

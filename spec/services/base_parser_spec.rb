RSpec.describe BaseParser do
  subject(:service) { described_class.new(link) }

  let(:link) { 'some_link' }

  describe '#initialize' do
    it 'initializes link to be parsed' do
      expect(service.instance_variable_get(:@link)).to eq(link)
    end
  end

  describe '#call' do
    it 'raises NotImplementedError' do
      expect { service.call }.to raise_error(NotImplementedError)
    end
  end
end

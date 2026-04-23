require_relative '../../services/message_processor'
require_relative '../../models/message_store'

RSpec.describe MessageProcessor do
  let(:valid_params) { { 'phone' => '123456', 'message' => 'hola' } }
  let(:info_params) { { 'phone' => '123456', 'message' => 'quiero información' } }
  let(:price_params) { { 'phone' => '123456', 'message' => 'cuál es el precio' } }

  describe '#process' do
    it 'validates missing phone' do
      processor = MessageProcessor.new({ 'message' => 'test' })
      result = processor.process
      expect(result[:status]).to eq(400)
    end

    it 'returns info response' do
      processor = MessageProcessor.new(info_params)
      result = processor.process
      expect(result[:response]).to include('contactaremos')
    end

    it 'returns price response' do
      processor = MessageProcessor.new(price_params)
      result = processor.process
      expect(result[:response]).to include('29€')
    end

    it 'saves the message to the store' do
      MessageStore.instance.clear!
      processor = MessageProcessor.new(valid_params)
      processor.process
      expect(MessageStore.instance.all.size).to eq(1)
    end
  end
end

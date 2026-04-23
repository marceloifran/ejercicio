require_relative '../models/message_store'
require_relative '../models/message'

class MessageProcessor
  def initialize(params)
    @phone = params['phone']
    @message = params['message']
    @store = MessageStore.instance
  end

  def process
    return { error: 'Invalid request', status: 400 } if invalid_params?

    response_text = generate_response
    message_obj = Message.new(phone: @phone, content: @message, response: response_text)
    @store.save(message_obj)

    { response: response_text, status: 200 }
  end

  private

  def invalid_params?
    @phone.nil? || @phone.to_s.strip.empty? || @message.nil? || @message.to_s.strip.empty?
  end

  def generate_response
    normalized_message = @message.to_s.downcase

    if normalized_message.include?('información')
      'Gracias por tu interés. En breve te contactaremos.'
    elsif normalized_message.include?('precio')
      'Nuestros precios comienzan desde 29€ al mes.'
    else
      'Gracias por escribirnos.'
    end
  end
end

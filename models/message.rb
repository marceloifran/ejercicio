class Message
  attr_reader :phone, :content, :response, :timestamp

  def initialize(phone:, content:, response:)
    @phone = phone
    @content = content
    @response = response
    @timestamp = Time.now
  end

  def to_h
    {
      phone: @phone,
      content: @content,
      response: @response,
      timestamp: @timestamp
    }
  end
end

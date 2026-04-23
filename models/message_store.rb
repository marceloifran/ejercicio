class MessageStore
  def initialize
    @messages = []
  end

  def self.instance
    @instance ||= new
  end

  def save(phone, message, response)
    entry = {
      phone: phone,
      message: message,
      response: response,
      timestamp: Time.now
    }
    @messages << entry
    entry
  end

  def all
    @messages
  end

  def clear!
    @messages = []
  end
end

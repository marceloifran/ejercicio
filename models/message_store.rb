class MessageStore
  def initialize
    @messages = []
  end

  def self.instance
    @instance ||= new
  end

  def save(message_obj)
    @messages << message_obj
    message_obj
  end

  def all
    @messages
  end

  def clear!
    @messages = []
  end
end

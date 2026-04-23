require 'sinatra'
require 'sinatra/json'
require 'logger'
require_relative 'services/message_processor'

class WebhookApp < Sinatra::Base
  helpers Sinatra::JSON

  configure do
    set :logger, Logger.new(STDOUT)
    set :show_exceptions, false
  end

  before do
    content_type :json
  end

  # Health check
  get '/' do
    json({ status: 'online', service: 'Webhook Processor' })
  end

  post '/webhook' do
    # Parsing body safely
    begin
      request_payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      status 400
      return json({ error: 'Invalid JSON' })
    end

    logger.info "Received request: #{request_payload}"

    processor = MessageProcessor.new(request_payload)
    result = processor.process

    if result[:status] == 400
      status 400
      json({ error: result[:error] })
    else
      status 200
      json({ response: result[:response] })
    end
  end

  # Error Handling
  error 404 do
    json({ error: 'Not Found' })
  end

  error 500 do
    json({ error: 'Internal Server Error' })
  end
end

# To run with: ruby app.rb
if __FILE__ == $0
  WebhookApp.run!
end

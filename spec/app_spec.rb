require 'spec_helper'

RSpec.describe 'Webhook API' do
  it 'returns 400 when phone is missing' do
    post '/webhook', { message: 'Hola' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    
    expect(last_response.status).to eq(400)
    expect(JSON.parse(last_response.body)['error']).to eq('Invalid request')
  end

  it 'returns 400 when message is missing' do
    post '/webhook', { phone: '123' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    
    expect(last_response.status).to eq(400)
    expect(JSON.parse(last_response.body)['error']).to eq('Invalid request')
  end

  it 'responds correctly to information request' do
    post '/webhook', { phone: '123', message: 'Quiero información' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)['response']).to eq('Gracias por tu interés. En breve te contactaremos.')
  end

  it 'responds correctly to price request' do
    post '/webhook', { phone: '123', message: '¿Cuál es el precio?' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)['response']).to eq('Nuestros precios comienzan desde 29€ al mes.')
  end

  it 'responds with default message for other inputs' do
    post '/webhook', { phone: '123', message: 'Hola, ¿cómo estás?' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)['response']).to eq('Gracias por escribirnos.')
  end

  it 'handles lowercase/case-insensitive messages' do
    post '/webhook', { phone: '123', message: 'PRECIO' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)['response']).to eq('Nuestros precios comienzan desde 29€ al mes.')
  end
end

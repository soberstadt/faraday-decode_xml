# frozen_string_literal: true

RSpec.describe Faraday::DecodeXML::Middleware do
  let(:conn) do
    Faraday.new do |faraday|
      faraday.response :xml

      faraday.adapter :test do |stub|
        stub.get('ok') { [200, { 'Content-Type' => "#{content_type}; character-set: utf-8" }, body] }
      end
    end
  end
  let(:content_type) { 'application/xml' }
  let(:body) do
    '<root><foo>bar</foo></root>'
  end

  it 'parses body into hash' do
    me = conn.get('/ok').body

    expect(me).to eq 'root' => { 'foo' => 'bar' }
  end

  context 'when body is not XML' do
    let(:body) { 'asdf' }

    it 'raises error' do
      expect { conn.get('/ok').body }.to raise_error(Faraday::ParsingError)
    end
  end

  context 'when content type is not XML' do
    let(:content_type) { 'text/plain' }

    it 'does not parse body' do
      expect(conn.get('/ok').body).to eq body
    end
  end
end

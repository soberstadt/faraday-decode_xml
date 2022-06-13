# frozen_string_literal: true

require_relative 'decode_xml/middleware'
require_relative 'decode_xml/version'

module Faraday
  # This will be your middleware main module, though the actual middleware implementation will go
  # into Faraday::DecodeXML::Middleware for the correct namespacing.
  module DecodeXML
    # Faraday allows you to register your middleware for easier configuration.
    # This step is totally optional, but it basically allows users to use a
    # custom symbol (in this case, `:decode_xml`), to use your middleware in their connections.
    # After calling this line, the following are both valid ways to set the middleware in a connection:
    # * conn.use Faraday::DecodeXML::Middleware
    # * conn.use :decode_xml
    # Without this line, only the former method is valid.
    Faraday::Response.register_middleware(xml: Faraday::DecodeXML::Middleware)

    # Alternatively, you can register your middleware under Faraday::Request or Faraday::Response.
    # This will allow to load your middleware using the `request` or `response` methods respectively.
    #
    # Load middleware with conn.request :decode_xml
    # Faraday::Request.register_middleware(decode_xml: Faraday::DecodeXML::Middleware)
    #
    # Load middleware with conn.response :decode_xml
    # Faraday::Response.register_middleware(decode_xml: Faraday::DecodeXML::Middleware)
  end
end

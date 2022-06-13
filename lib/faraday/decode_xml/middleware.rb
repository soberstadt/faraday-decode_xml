# frozen_string_literal: true

require 'multi_xml'

module Faraday
  module DecodeXML
    # Faraday middleware for decoding XML requests.
    class Middleware < Faraday::Middleware
      # @param env [Faraday::Env] the environment of the response being processed.
      def on_complete(env)
        process_response(env) if process_response_type?(response_type(env)) && parse_response?(env)
      end

      private

      def process_response(env)
        env.body = parse(env.body)
      rescue Faraday::ParsingError => e
        raise Faraday::ParsingError.new(e.wrapped_exception, env[:response])
      end

      def parse(body)
        ::MultiXml.parse(body, {})
      rescue StandardError, SyntaxError => e
        raise e if e.is_a?(SyntaxError)

        raise Faraday::ParsingError, e
      end

      def response_type(env)
        env.response_headers['Content-Type'].to_s.split(';', 2).first
      end

      def process_response_type?(type)
        type == 'application/xml'
      end

      def parse_response?(env)
        env.body.respond_to? :to_str
      end
    end
  end
end

require 'json'
require 'uri'

module HttpBaseline
  module Adapter
    class Abstract

      def initialize(config)
        @config   = config
        @options  = { :ssl => @config.ssl.enabled.true?, :ssl_options => { :verify => @config.ssl.verify } }
        @protocol = @config.ssl.enabled.true? ? 'https' : 'http'
        @uri      = URI.parse("#{@protocol}://#{@config.domain}:#{@config.tcp_port}")
      end

      def ssl?
        @uri.scheme == 'https'
      end

      def headers
        @client.headers
      end

    end
  end
end
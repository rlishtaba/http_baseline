module HttpBaseline
  module Adapter
    class Rest < Abstract
      require 'faraday'
      require 'faraday/request/multipart'
      require 'faraday_middleware'
      require 'http_baseline/adapter/rest/response/logger'

      attr_reader :uri

      def initialize(config)
        super
        @client              = Faraday.new do |pipe|
          pipe.use Faraday::Request::UrlEncoded
          pipe.use FaradayMiddleware::EncodeJson
          pipe.use FaradayMiddleware::FollowRedirects
          pipe.use FaradayMiddleware::Mashify
          pipe.use Response::Logger
          pipe.url_prefix = @uri
        end
        headers[:user_agent] = 'WS v%s' % HttpBaseline::VERSION
      end


      def attach_extension(other_module)
        @client.use other_module
      end


      def get(url, *args)
        @client.get(configured_path(url), *args)
      end


      def post(url, body = nil, *args)
        @client.post(configured_path(url), body, *args)
      end


      def delete(url, *args)
        @client.delete(configured_path(url), *args)
      end

      def put(url, body = nil, *args)
        @client.put(configured_path(url), body, *args)
      end

      private

      def configured_path(url)
        @config.path_prefix.to_s + url
      end

      def reset_config
        @client.url_prefix = @uri.to_s
        if @options[:ssl_options]
          @client.ssl.merge!(@options[:ssl_options])
        end
      end

    end
  end
end
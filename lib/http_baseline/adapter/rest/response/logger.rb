module HttpBaseline
  module Adapter
    class Rest
      module Response
        class Logger < Faraday::Response::Middleware
          extend Forwardable

          def initialize(app, logger = nil)
            super(app)
            @logger = logger || HttpBaseline.logger
          end

          def_delegators :@logger, :debug, :info, :warn, :error, :fatal

          def call(env)
            info('request') { '[%s] %s: %s' % ['TX', env.method.upcase, env.url.to_s] }
            dump_headers(env.request_headers) do |line|
              debug('response') { '[%s] %s' % ['TX', line] }
            end
            debug('request') { '[%s] %s' % ['TX', env.body] } if env.body
            super
          end

          def on_complete(env)
            info('status') { '[%s] %s' % ['RX', env.status.to_s] }
            dump_headers(env.response_headers) do |line|
              debug('response') { '[%s] %s' % ['RX', line] }
            end
            debug('response') { '[%s] %s' % ['RX', env.body] }
          end

          private

          def dump_headers(headers)
            max = headers.keys.map { |k| k.length }.max + 2
            headers.map { |k, v| yield "%-#{max}s: #{v.inspect}" % k }
          end

        end
      end
    end
  end
end
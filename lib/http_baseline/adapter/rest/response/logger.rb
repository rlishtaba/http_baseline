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
            debug "#{env.method} #{env.url.to_s}"
            debug('request') { dump_headers env.request_headers }
            debug('request') { env.body }
            super
          end

          def on_complete(env)
            debug('Status') { env.status.to_s }
            debug('response') { dump_headers env.response_headers }
            debug('response') { env.body }
          end

          private

          def dump_headers(headers)
            headers.map { |k, v| "#{k}: #{v.inspect}" }.join("\n")
          end
        end
      end
    end
  end
end
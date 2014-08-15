module HttpBaseline
  class Abstract < ::Evf::Abstract

    config.comm                  = Evf::Support::Options.new unless config.respond_to?(:comm)
    config.comm.http             = Evf::Support::Options.new
    config.comm.http.ssl         = Evf::Support::Options.new
    config.comm.http.ssl.enabled = 'no'

    invocation 'init.http.config', :before => :load_context_config, :group => :all do |env|
      HttpBaseline.config      = env.config
      HttpBaseline.logger      = env.config.logger
      HttpBaseline.broadcaster = env.broadcaster

      %w(debugging header request response user_story).each do |definition|
        require HttpBaseline::SHARED_DEFINITIONS.join('%s_steps' % definition)
      end

    end

  end
end
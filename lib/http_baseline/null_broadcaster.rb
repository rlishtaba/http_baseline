module HttpBaseline
  class NullBroadcaster

    def initialize(logger)
      @logger = logger
    end

    def notify_all_with(object, notification_type, *args)
      @logger.debug '[%s]: %s -> accepted :%s with %s' % [uname, object.class.name, notification_type, args.join(', ')]
    end

    def uname
      @uname ||= self.class.name.split('::').last
    end

    def subscribe(other)
      (@null_storage ||= []) << other
    end

  end
end
$:.unshift File.expand_path '../', __FILE__
require 'http_baseline/version'
require 'base64'
require 'bigdecimal'
require 'cgi'
require 'date'
require 'digest/sha1'
require 'enumerator'
require 'forwardable'
require 'net/http'
require 'net/https'
require 'openssl'
require 'stringio'
require 'time'
require 'zlib'
require 'builder'
require 'json'
require 'jsonpath'
require 'logger'
require 'addressable/uri'
require 'ext_core/query'
require 'ext_core/object'
require 'ext_core/array'
require 'ext_core/hash'
require 'ext_core/string'
require 'hashie'

module HttpBaseline
  SHARED_DEFINITIONS = Pathname(__FILE__).join('..', '..', 'features', 'step_definitions', 'generic')

  autoload :Methods, 'http_baseline/methods'
  autoload :NullBroadcaster, 'http_baseline/null_broadcaster'

  module Adapter
    autoload :Abstract, 'http_baseline/adapter/abstract'
    autoload :Rest, 'http_baseline/adapter/rest'
  end

  class << self
    attr_writer :config
  end

  def self.config
    @config ||= Hashie::Mash.new
  end

  def self.logger
    @logger ||= begin
      logger       = ::Logger.new $stdout
      logger.level = ::Logger::DEBUG
      logger
    end
  end

  def self.logger=(val)
    @logger = val
  end

  def self.broadcaster
    @broadcaster ||= NullBroadcaster.new(self.logger)
  end

  def self.broadcaster=(other_bundle)
    @broadcaster = other_bundle
  end

end

module Sunstore::Handler

  require_relative 'handlers/json'
  require_relative 'handlers/yaml'

  def self.for(protocol)
    case protocol
    when :yaml then YAML.new
    when :json then JSON.new
    else
      raise "Only :yaml and :json currently supported"
    end
  end
end
require "sunstore/version"
require "sunstore/store"

module Sunstore

  def self.config(params)
    Store.instance.config(params)
  end

  def self.get(key)
    Store.instance.get(key)
  end

  def self.put(key,value)
    Store.instance.put(key,value)
  end  

  def self.delete(key)
    Store.instance.delete(key)
  end

  def self.keys
    Store.instance.keys
  end

  def self.clear
    Store.instance.clear
  end

end

require_relative 'handler'

class Sunstore::Store

  @@instance = nil

  attr_reader :format, :basename, :handler, :store_file

  def self.instance
    @@instance ||= new
  end

  def self.reset
    @@instance = nil
  end

  def initialize
    config  
  end

  def config(params={})
    @format = [:yaml,:json,nil].include?(params[:format]) ? params[:format] || :yaml : raise("Only yaml and json currently supported")
    @basename = params[:basename] || "sunstore"
    @basedir = params[:basedir] ||  (defined?(Rails) ? Rails.root.join('tmp').to_s : Dir.getwd)
    create_dir_structure(@basedir)
    @handler = Sunstore::Handler.for(format)
    @store_file = File.join(@basedir,"#{@basename}.#{@handler.type}")
  end

  def get(key)
    data[key]
  end

  def put(key,value)
    data[key] = value
    save_data
  end

  def delete(key)
    data.delete(key)
    save_data
  end

  def keys
    data.keys  
  end

  def clear
    data.clear
    save_data  
  end

  private

  def save_data
    File.open(store_file,"w") do |f|
      f.write @handler.serialize(@data)
    end
  end

  def data
    unless @data 
      if File.exist?(store_file)
        @data = @handler.deserialize(File.read(store_file)) || {}
      else
        @data = {}
      end
    end
    @data
  end

  def create_dir_structure(target_dir)
    curdir = ''
    target_dir.split('/').each do |dir|
      curdir = File.join(curdir,dir)
      Dir.exist?(curdir) or Dir.mkdir(curdir)
    end
  end

end

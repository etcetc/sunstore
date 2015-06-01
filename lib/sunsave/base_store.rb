# Module defines the interface to sunsave
class BaseStore

  @@basename = 'sunstore'

  def self.basename=(name)
    @@basename = name
  end

  def self.basename
    @@basename
  end
  
  def put(key,value)
    raise "put must be implemented by actual store instance"
  end

  def get(key)
    raise "get
     must be implemented by actual store instance"    
  end

  private

  # defines the file store
  def file_store_root
    dir = defined?(Rails) ? Rails.root : Dir.getwd
    File.join(dir,self.class.basename)
  end

end
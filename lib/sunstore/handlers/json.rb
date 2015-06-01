class Sunstore::Handler::JSON 

  require 'JSON'

  def serialize(h)
      h.to_json
  end

  def deserialize(txt)
    JSON.parse(txt)
  end

  def type
    "json"
  end
end
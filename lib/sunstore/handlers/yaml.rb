class Sunstore::Handler::YAML
  require 'Psych'

  def serialize(h)
      h.to_yaml
  end

  def deserialize(txt)
    Psych.load(txt)
  end

  def type
    "yaml"
  end
end

class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      getter(name)
      setter(name)
    end
  end

  def self.getter(name)
    define_method(name) { self.instance_variable_get("@#{name}") }
  end

  def self.setter(name)
    set = "#{name}="
    define_method(set) do |var|
      self.instance_variable_set("@#{name}", var)
    end
  end
end

# p AttrAccessorObject.my_attr_accessor("this", "that")

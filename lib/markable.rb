%w{rubygems markaby}.each {|lib| require lib}

module Markable
  def self.included(other)
    other.send(:undef_method, :p)
  end
  
  def mab(&block)
    Markaby::Builder.new({}, self, &block)
  end
  
  def method_missing(*args, &block)
    Markaby::Builder.new({}, self).capture {send(*args, &block)}
  end
end
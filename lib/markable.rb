%w{rubygems markaby}.each {|lib| require lib}

module Markable
  def self.included(other)
    # Kernel.p conflicts with Markaby's method_missing for <p> tags.
    # Be careful of any other methods.
    # Note that Kernel.p is still available.
    other.send(:undef_method, :p)
  end
  
  # Use this to invoke markaby
  def mab(&block)
    Markaby::Builder.new({}, self, &block)
  end
  
  # This allows us to make helper methods that can act as partials.  Otherwise, they wouldn't
  # know what to do when they saw the beginning of a Markaby block without the containing #mab.
  def method_missing(*args, &block)
    Markaby::Builder.new({}, self).capture {send(*args, &block)}
  end
end
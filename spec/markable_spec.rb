require File.join(File.dirname(__FILE__), '..', 'lib', "markable")

class Sample
  include Markable
  
  attr_reader :title, :text
  def initialize(title, text)
    @title, @text = title, text
  end
  
  def format
    mab do
      html do
        head do
          title @title
        end
        body do
          p @text
        end
      end
    end
  end
  
end

class SampleWithHelpers
  include Markable
  
  attr_reader :title, :text
  def initialize(title, text)
    @title, @text = title, text
  end
  
  def format
    mab do
      html do
        head do
          title @title
        end
        body do
          red_paragraph
        end
      end
    end
  end
  
  def red_paragraph
    p :style => "red" do
      @text
    end
  end
end

class SampleWithMethodMissing < SampleWithHelpers
  def initialize(*args)
    super(*args[0..1])
    @data = args[2]
  end
  
  def method_missing(*a, &b)
    return super(*a, &b) unless value = @data[a.first]
    value
  end
end

describe Markable do
  it "should produce html output when :format called" do
    s = Sample.new("Foo", "Hello, Markable!")
    s.format.should == %{<html><head><meta content="text/html; charset=utf-8" http-equiv="Content-Type"/><title>Foo</title></head><body><p>Hello, Markable!</p></body></html>}
  end

  it "should produce html output when :format called with helpers" do
    s = SampleWithHelpers.new("Foo", "Hello, Markable!")
    s.format.should == %{html><head><meta content="text/html; charset=utf-8" http-equiv="Content-Type"/><title>Foo</title></head><body><p style="red">Hello, Markable!</p></body></html>}
  end
  
  it "should not interfere with normal method_missing definitions" do
    s = SampleWithMethodMissing.new("Foo", "Hello, Markable!", :red => "green", :html => "Whassup?")
    s.html.should == "Whassup?"
    s.format.should == %{html><head><meta content="text/html; charset=utf-8" http-equiv="Content-Type"/><title>Foo</title></head><body><p style="red">Hello, Markable!</p></body></html>}
  end
end


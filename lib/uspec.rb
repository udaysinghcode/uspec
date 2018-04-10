def describe(description, &block)
  OurBlock.new(block).evaluate!
end

class OurBlock
  def initialize(block)
    @block = block
  end

  def evaluate!
    instance_eval(&@block)
  end

  def it(description, &block)
    block.call
  end
end

class Object
  def should(comparison_object=nil)
    DelayedAssertion.new(self)
  end
end

class DelayedAssertion
  def initialize(subject)
    @subject = subject
  end

  def ==(other)
    raise AssertionError unless @subject == other
  end
end

class AssertionError < Exception
end

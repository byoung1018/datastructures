class Node
  attr_accessor :next, :value, :prev
  def initialize(value)
    @next = nil
    @prev = nil
    @value = value

  end

  def inspect
    value.to_s
  end
end

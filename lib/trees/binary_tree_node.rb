class BinaryTreeNode
  attr_accessor :left, :right, :value, :parent

  def initialize(value)
    @value = value
  end

  def [](method)
    self.send(method)
  end

  def []=(method, value)
    self.send("#{method}=", value)
  end

  def <=>(value)
    value = value.value if value.class.name == "BinaryTreeNode"
    @value > value ? "left" : "right"
  end


  def link_from_parent=(node)
    return unless @parent
    @parent[@parent <=> @value] = node
  end

  def detach()
    link_from_parent = nil
    @parent = nil
    ["left", "right"].each do |direction|
      self[direction].parent = nil if self[direction]
      self[direction] = nil
    end
  end

end

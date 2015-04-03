require_relative "list_node"

class LinkedList
  attr_reader :count
  def initialize()
    @head = nil
    @tail = nil
    @count = 0
  end

  def add(value)
    if @tail
      @tail.next = Node.new(value)
      @tail = @tail.next
    else
      @head = Node.new(value)
      @tail = @head
    end
    @count += 1
  end
  
end

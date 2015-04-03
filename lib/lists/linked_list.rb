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

  def add_first(value)
    if @head
      new_head = Node.new(value)
      new_head.next = @head
      @head = new_head
    else
      @head = Node.new(value)
      @tail = @head
    end
    @count += 1
  end

  def add_last(value)
    add(value)
  end

  def add_at(index, value)
    node_before = get_node(index-1)
    new_node = Node.new(value)
    new_node.next = node_before.next
    node_before.next = new_node
    @count += 1
  end

  def contains(value)
    return !!find(value)
  end

  def get(index)
    node = get_node(index)
    node ? node.value : nil
  end

  def get_node(index)
    raise "index out of range" if index >= count
    i = 0
    each {|node| i == index ? (return node) : i += 1}

    nil
  end

  def delete_at(index)
    if index == 0
      delete_first
    # elsif index == count - 1
    #   delete_last
    else
     delete_next_node(get_node(index-1))
    end
  end

  def delete_first
    @head = @head.next
    @count -= 1
    @tail = nil if @count == 0
  end

  def delete_last

  end

  def delete(value)
    if @head.value == value
      delete_first
      return
    end

    each do |node|
      if node.next && node.next.value == value
        delete_next_node(node)
        return
      end
    end
  end

  def find(value)
    self.each{|node| return node if node.value == value}

    nil
  end

  def each
    node = @head
    while node
      yield node
      node = node.next
    end
  end

  def print
    self.each{|node| p node}
  end

  def index_of(value)
    i = 0
    each {|node| node.value == value ? (return i) : i += 1}

    nil
  end

  def get_first
    @head.value
  end

  def get_last
    @tail.value
  end

  def get_first_node
    @head
  end

  def get_last_node
    @tail
  end

  private
    def delete_next_node(node)
      node.next = node.next.next
      @tail = node if node.next == nil
      @count -= 1
    end
end

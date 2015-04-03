require_relative "binary_tree_node"

class BST
  attr_reader :size
  def initialize
    @size = 0
  end

  def add(value)
    new_node = BinaryTreeNode.new(value)
    if !@root
      @root = new_node
      return
    end
    insert(new_node, @root)
    @size += 1
  end

  def contains(value)
    return !!find(value)
  end

  def find(value, node = @root)
    return node if node.value == value
    direction = node <=> value
    return nil unless node[direction]
    find(value, node[direction])
  end

  def each_descending(node = @root, &proc)
    each_descending(node.right, &proc) if node.right
    proc.call(node)
    each_descending(node.left, &proc) if node.left
  end

  def each_ascending(node = @root, &proc)
    each_ascending(node.left, &proc) if node.left
    proc.call(node)
    each_ascending(node.right, &proc) if node.right
  end

  def remove(value)
    node = value.class.name == "BinaryTreeNode" ? value : find(value)
    raise "value not found" unless node
    parent = node.parent
    if !(node.left || node.right)
      node.link_from_parent = nil
    elsif node.left && node.right
      replacement_node = lowest_node(node.right)
      remove(replacement_node)
      replace(node, replacement_node)
      @root = replacement_node if value == @root.value
    else
      direction = node.left ? "left" : "right"
      node.link_from_parent = node[direction]
      node[direction].parent = node.parent
      @root = node[direction] if value == @root.value

    end
  end


  def highest_node(node = @root)
    node.right ? highest_node(node.right) : node
  end

  def lowest_node(node = @root)
    node.left ? lowest_node(node.left) : node
  end

  def highest(node = @root)
    node.right ? highest(node.right) : node.value
  end

  def lowest(node = @root)
    node.left ? lowest(node.left) : node.value
  end

  private
    def insert(insert_node, location_node)
      direction = location_node <=> insert_node
      if location_node[direction]
        insert(insert_node, location_node[direction])
      else
        location_node[direction] = insert_node
        insert_node.parent = location_node
      end
    end

    def replace(old_node, new_node)
      new_node.detach
      ["left", "right"].each do |direction|
        old_node[direction].parent = new_node if old_node[direction]
        new_node[direction] = old_node[direction]
      end
      new_node.parent = old_node.parent
      old_node.link_from_parent = new_node
    end

    def shift_up(node)
      new_parent = node.parent.parent
      direction = new_parent <=> node
      new_parent[direction] = node
      node.parent = new_parent
    end

end

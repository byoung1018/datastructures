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

end

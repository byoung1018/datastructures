require "trees/bst"

def bfs_compare(expected_values)
  queue = [bst.instance_variable_get(:@root)]
  i = 0
  until queue.empty?
    node = queue.shift
    expect(node.value).to eq(expected_values[i])
    i += 1
    [:left, :right].each do |direction|
      next_node = node.send(direction)
      next unless next_node
      if direction == :left
        expect(next_node.value).to be < node.value
      else
        expect(next_node.value).to be > node.value
      end
      queue << next_node
      expect(next_node.parent.value).to eq(node.value)
    end
  end
end

describe BST do
  subject(:bst) {BST.new}

  before(:each) do
    bst.add(8)
    bst.add(3)
    bst.add(10)
    bst.add(1)
    bst.add(6)
    bst.add(14)
    bst.add(4)
    bst.add(7)
    bst.add(13)
  end

  describe "#add" do
    it "can have nodes added" do
      bfs_compare([8, 3, 10, 1, 6, 14, 4, 7, 13])
    end
  end

end

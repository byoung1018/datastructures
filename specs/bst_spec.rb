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

  describe "#contains" do
    it "can return whether the tree has the given value or not" do
      bfs_compare([8, 3, 10, 1, 6, 14, 4, 7, 13])
      expect(bst.contains(8)).to be_truthy
      expect(bst.contains(3)).to be_truthy
      expect(bst.contains(10)).to be_truthy
      expect(bst.contains(1)).to be_truthy
      expect(bst.contains(6)).to be_truthy
      expect(bst.contains(14)).to be_truthy
      expect(bst.contains(4)).to be_truthy
      expect(bst.contains(7)).to be_truthy
      expect(bst.contains(13)).to be_truthy
      expect(bst.contains(2)).to be_falsy
      expect(bst.contains(50)).to be_falsy
      expect(bst.contains(-1)).to be_falsy
    end

    it "does not mutate the tree" do
      bfs_compare([8, 3, 10, 1, 6, 14, 4, 7, 13])
    end
  end

  describe "#each_descending" do
    it "" do
      descending = []
      bst.each_descending {|node| descending << node.value}
      expect(descending).to eq([14, 13, 10, 8, 7, 6, 4, 3, 1])
    end
  end

  describe "#each_ascending" do
    it "" do
      ascending = []
      bst.each_ascending {|node| ascending << node.value}
      expect(ascending).to eq([1, 3, 4, 6, 7, 8, 10, 13, 14])
    end
  end

  describe "#remove" do
    it "can remove a leaf" do
      bst.remove(4)
      bfs_compare([8, 3, 10, 1, 6, 14, 7, 13])
    end
    it "can remove a node with one child" do
      bst.remove(14)
      bfs_compare([8, 3, 10, 1, 6, 13, 4, 7])
    end
    it "can remove a node with two children" do
      bst.remove(3)
      bfs_compare([8, 4, 10, 1, 6, 14, 7, 13])
    end

    it "can remove the root with one child" do
      bst.remove(3)
      bst.remove(6)
      bst.remove(1)
      bst.remove(4)
      bst.remove(7)
      bst.remove(8)
      bfs_compare([10, 14, 13])
    end

    it "can remove the root with two children" do
      bst.remove(8)
      bfs_compare([10, 3, 14, 1, 6, 13, 4, 7, 13])
    end
  end

  describe "#highest" do
    it "returns the highest number" do
      expect(bst.highest).to eq(14)
    end
  end

  describe "#lowest" do
    it "returns the lowest number" do
      expect(bst.lowest).to eq(1)
    end
  end
end

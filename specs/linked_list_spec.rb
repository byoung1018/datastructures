require "lists/linked_list"
def check_integrity(expected_values)
  head = list.instance_variable_get(:@head)
  tail = list.instance_variable_get(:@tail)
  expect(head.value).to eq(expected_values.first)
  expect(tail.value).to eq(expected_values.last)
  expect(list.instance_variable_get(:@count)).to eq(expected_values.length)
  current_node = head
  expected_values.each do |expected_value|
    expect(current_node.value).to eq(expected_value)
    current_node = current_node.next
  end
end

def list_empty?
  expect(head = list.instance_variable_get(:@head)).to be_nil
  expect(list.instance_variable_get(:@tail)).to be_nil
  expect(list.instance_variable_get(:@count)).to eq(0)
end


describe LinkedList do

  subject(:list) {LinkedList.new}
  before(:each) do
    list.add("first")
    list.add("second")
    list.add("third")
  end

  describe "#add" do
    it "adds values to the list" do
      check_integrity(["first", "second", "third"])
    end
  end

  describe "#add_first" do
    it "adds values to the front of the list" do
      list.add_first("zeroth")
      list.add_first("uhhh...")
      check_integrity(["uhhh...", "zeroth", "first", "second", "third"])
    end
  end


  describe "#add_last" do
    it "adds a value to the end of the list" do
      list.add_last("fourth")
      list.add_last("fifth")
      check_integrity(["first", "second", "third", "fourth", "fifth"])
    end
  end

  describe "#add_at" do
    it "adds a value at the given index" do
      list.add_at(1, "1.5")
      check_integrity(["first", "1.5", "second", "third"])

    end
  end

  describe "#contains" do
    it "returns if the given value is in the list" do
      expect(list.contains("zeroth")).to be_falsey
      expect(list.contains("first")).to be_truthy
      expect(list.contains("second")).to be_truthy
      expect(list.contains("third")).to be_truthy
    end

    it "doesn't mutate the list" do
      check_integrity(["first", "second", "third"])
    end
  end

  describe "#get" do
    it "gets the value at the given index" do
      expect(list.get(0)).to eq("first")
      expect(list.get(1)).to eq("second")
      expect(list.get(2)).to eq("third")
    end
  end

  describe "#delete_at" do
    it "can delete a node in the middle of the list" do
      list.delete_at(1)
      check_integrity(["first", "third"])
    end

    it "can delete a node at the end of the list" do
      list.delete_at(2)
      check_integrity(["first",  "second"])
    end

    it "can delete a node at the beginning of the list" do
      list.delete_at(0)
      check_integrity(["second", "third"])
    end

    it "can delete a node at the end of a two item list" do
      list.delete_at(1)
      list.delete_at(1)
      check_integrity(["first"])
    end

    it "can delete a node at the beginning of a two item list" do
      list.delete_at(0)
      list.delete_at(0)
      check_integrity(["third"])
    end

    it "can delete a node in a one item list" do
      list.delete_at(2)
      list.delete_at(1)
      list.delete_at(0)
      list_empty?
    end

    it "raises an error if the index is out of range" do
      expect{list.delete_at(5)}.to raise_error("index out of range")
    end
  end

  describe "#delete_first" do
    it "deletes the first item in the list" do
      list.delete_first
      check_integrity(["second", "third"])
      list.delete_first
      check_integrity(["third"])
      list.delete_first
      list_empty?
    end
  end

  describe "#delete" do
    it "deletes the node with the given value" do
      list.delete("second")
      check_integrity(["first", "third"])
      list.delete("third")
      check_integrity(["first"])
      list.delete("first")
      list_empty?
    end
  end

  describe "#find" do
    it "finds the node with the given value" do
      expect(list.find("second").value).to eq("second")
    end
    it "returns nil if the value is not found" do
      expect(list.find("fifth")).to be_nil
    end
  end

  describe "#each" do
    it "runs the given block on each node" do
      list.each {|node| node.value = node.value + "!"}
      check_integrity(["first!", "second!", "third!"])
    end
  end

  describe "#index_of" do
    it "returns the index of the given value" do
      expect(list.index_of("first")).to eq(0)
      expect(list.index_of("second")).to eq(1)
      expect(list.index_of("third")).to eq(2)
      expect(list.index_of("fifth")).to be_nil
    end
  end


  describe "#get_first" do
    it "returns the head" do
      expect(list.get_first).to eq("first")
    end
  end

  describe "#get_last" do
    it "returns the tail" do
      expect(list.get_last).to eq("third")
    end
  end

end

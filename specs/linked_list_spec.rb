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
  
end

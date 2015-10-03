require "stacks/stack"


describe Stack do
  subject(:stack) {Stack.new}

  describe "#push" do
    it "adds a value to the top of the stack" do
      stack.push(1)
      stack.push(2)
      stack.push("a")
      stack.push("d")
      stack.push(7)

      expect(stack.instance_variable_get(:@stack)).to eq([1, 2, "a", "d", 7])
    end
  end
  describe "access methods" do
    before(:each) do
      stack.push(1)
      stack.push(2)
      stack.push("a")
      stack.push("d")
      stack.push(7)
    end

    describe"#pop" do
      it "removes a value from the top of the stack, and nil if empty" do
        expect(stack.pop).to eq(7)
        expect(stack.pop).to eq("d")
        expect(stack.pop).to eq("a")
        expect(stack.pop).to eq(2)
        expect(stack.pop).to eq(1)
        expect(stack.pop).to be_nil
      end
    end

    describe "#peek" do
      it "returns the top value on the stack without removing the value" do
        expect(stack.peek).to eq(7)
        stack.pop
        expect(stack.peek).to eq("d")
        stack.pop
        expect(stack.peek).to eq("a")
        stack.pop
        expect(stack.peek).to eq(2)
        stack.pop
        expect(stack.peek).to eq(1)
        stack.pop
      end
    end
  end
end

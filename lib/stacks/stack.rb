class Stack

  def initialize
    @stack = []
    @next_empty = 0
  end



  def push(value)
    @stack[@next_empty] = value
    @next_empty += 1
  end



  def pop
    return nil if @next_empty == 0
    @next_empty -= 1

    @stack[@next_empty]
  end



  def peek
    return nil if @next_empty == 0

    @stack[@next_empty - 1]
  end

end

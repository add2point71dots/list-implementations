class Node
  attr_accessor :data, :next

  def initialize(val,next_node=nil)
    @data = val
    @next = next_node
  end
end

class LinkedList
  def initialize
    @head = nil
    @size = 0
  end

  def add(value)
    # special case: if there aren't any nodes yet
    if @size == 0
      @head = Node.new(value)
      @size += 1
    else
      # Traverse to the end of the list
      # And insert a new node with the specified value
      current = @head
      while current.next != nil
        current = current.next
      end
      current.next = Node.new(value)
      @size += 1
    end
    self
  end

  def add_in_order(value)
    if @size == 0
      @head = Node.new(value)
    elsif value < @head.data
      @head = Node.new(value, @head)
    else
      current = @head
      loop do
        if current.next == nil
          current.next = Node.new(value)
          break
        elsif current.next.data >= value
          current.next = Node.new(value, current.next)
          break
        end
        current = current.next
      end
    end
    @size += 1
  end

  def delete(val)
    return nil if @size == 0
    if @head.data == val
      # If the head is the element to be delete, the head needs to be updated
      @head = @head.next
      @size -= 1
    else
      # ... x -> y -> z
      # Suppose y is the value to be deleted, you need to reshape the above list to :
      #   ... x->z
      previous = @head
      current = @head.next
      while current != nil && current.data != val
        previous = current
        current = current.next
      end

      if current != nil
        previous.next = current.next
        @size -= 1
      end
    end
  end


  def include?(key)
    current = @head
    while current != nil
      return true if current.data == key
      current = current.next
    end
    return false
  end

  def size
    return @size
  end

  def max
    return nil if @size == 0
    current = @head
    max = current.data
    while current != nil
      if current.data > max
        max = current.data
      end
      current = current.next
    end
    return max
  end

  def to_s
    return "[]" if @head == nil
    # Traverse through the list till you hit the "nil" at the end
    current = @head
    full_list = []
    while current.next != nil
      full_list += [current.data.to_s]
      current = current.next
    end
    full_list += [current.data.to_s]
    return full_list.join("->")
  end
end

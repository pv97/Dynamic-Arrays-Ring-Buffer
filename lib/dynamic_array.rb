require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0

  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    resize! if index >= @capacity

    if index+1 > length
      @length = index+1
    end

    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    value = @store[@length-1]
    @length -= 1
    return value
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    # debugger
    resize! if length == @capacity

    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0
    value = @store[0]
    for i in 0..@length-2
      @store[i] = @store[i+1]
    end
    @length -= 1
    return value
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == @capacity
    for i in 0..@length-1
      @store[@length-i] = @store[@length-i-1]
    end
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    old = @store
    @store = StaticArray.new(@capacity*2)
    (0..@length-1).each do |idx|
      @store[idx] = old[idx]
    end
    @capacity *= 2
  end
end

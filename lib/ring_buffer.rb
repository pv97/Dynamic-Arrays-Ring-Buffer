require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
    @start = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if length == 0 || index >= @length
    @store[(@start+index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    resize! if index >= @capacity

    if index > length
      @length = (@start+index) % @capacity + 1
    elsif @store[(@start+index) % @capacity] == nil
      @length += 1
    end

    @store[(@start+index) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0
    value = self[@length-1]
    @length -= 1
    return value
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    self[@length] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if length == 0
    value = self[0]
    @length -= 1
    @start = (@start+1) % @capacity
    return value
  end

  # O(1) ammortized
  def unshift(val)
    resize! if length == @capacity
    @start = (@start-1) % @capacity
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    old = @store
    old_capacity = @capacity
    @capacity *= 2
    @store = StaticArray.new(@capacity)
    (0..old_capacity-1).each do |idx|
      @store[(@start+idx) % @capacity] = old[(@start+idx) % old_capacity]
    end
  end
end

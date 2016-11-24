# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length)
    @array = Array.new(length)
  end

  # O(1)
  def [](index)
    @array[index]
  end

  # O(1)
  def []=(index, value)
    if index >= 0 && index < @array.length
      @array[index] = value
    else
      puts "invalid index"
    end
  end

  protected
  attr_accessor :store
end

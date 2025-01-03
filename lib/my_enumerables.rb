module Enumerable # rubocop:disable Style/Documentation
  def my_map
    new_array = []
    my_each do |item|
      new_array << yield(item)
    end

    new_array
  end

  def my_select
    new_array = []
    my_each do |item|
      new_array << item if yield(item)
    end
    new_array
  end

  def my_each_with_index
    index = 0
    my_each do |item|
      yield(item, index) if yield(item, index) == true
      index += 1
    end
    self
  end

  def my_all?
    my_each do |item|
      return false unless yield(item)
    end
    true
  end

  def my_none?
    my_each do |item|
      return false if yield(item)
    end
    true
  end

  def my_any?
    my_each do |item|
      return true if yield(item)
    end
    false
  end

  def my_count
    if block_given?
      count = 0
      my_each do |item|
        count += 1 if yield(item) # Increment count if the block condition is met
      end
      count # Return the total count of items satisfying the condition
    else
      size # Return the size of the enumerable if no block is given
    end
  end

  def my_inject(initial_value = nil)
    memo = initial_value

    each do |item|
      memo = if memo.nil?
               item
             else
               yield(memo, item)
             end
    end

    memo
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each(&)
    each(&block)

    self
  end
end

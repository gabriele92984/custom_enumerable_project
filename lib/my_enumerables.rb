# frozen_string_literal: true

module Enumerable # rubocop:disable Style/Documentation
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    my_each do |element|
      yield(element, index)
      index += 1
    end

    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    selected = []
    my_each do |element|
      selected << element if yield(element)
    end
    selected
  end

  def my_all?
    if block_given?
      my_each { |element| return false unless yield(element) }
    else
      # When no block is given, checks if all elements are truthy
      my_each { |element| return false unless element }
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |element| return true if yield(element) }
    else
      # When no block is given, checks if any element is truthy (not false/nil)
      my_each { |element| return true if element }
    end
    false
  end

  def my_map
    new_array = []
    my_each do |item|
      new_array << yield(item)
    end

    new_array
  end

  def my_none?
    my_each do |item|
      return false if yield(item)
    end
    true
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
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end

    self
  end
end

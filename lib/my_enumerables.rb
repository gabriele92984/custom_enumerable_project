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

  def my_none?
    if block_given?
      my_each { |element| return false if yield(element) }
    else
      # When no block is given, checks if all elements are falsy (false or nil)
      my_each { |element| return false if element }
    end
    true
  end

  def my_count(item = nil, &block)
    return size unless block || item

    count = 0
    my_each do |element|
      if block
        count += 1 if block.call(element)
      elsif item
        count += 1 if element == item
      end
    end
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    mapped = []
    my_each do |element|
      mapped << yield(element)
    end

    mapped
  end

  def my_inject(initial = nil, sym = nil, &block)
    # Handle symbol/block combinations
    if sym && block
      raise ArgumentError, 'You cannot provide both a symbol and a block'
    elsif sym
      block = sym.to_proc
    end

    accumulator = initial.nil? ? nil : initial

    my_each do |element|
      accumulator = if accumulator.nil?
                      element
                    else
                      block.call(accumulator, element)
                    end
    end

    accumulator
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

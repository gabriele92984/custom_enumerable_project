module Enumerable
  def my_map
    new_array = []
    self.my_each do |item| 
      new_array << yield(item)
    end
    new_array
  end

  def my_select
    new_array = []
    self.my_each do |item|
      new_array << item if yield(item)
      end
    new_array
  end

  def my_each_with_index
    index = 0
    self.my_each do |item|
      yield(item, index) if yield(item, index) == true
      index += 1
    end
    self
  end

  def my_all?
    matches = []
    result = false

    self.my_each do |item|
      matches << item if yield(item)
    end
    result = self.size == matches.size
    result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    for item in self
      yield(item)
    end
    self
  end
end

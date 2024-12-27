module Enumerable
  def my_map
    new_array = []
    self.my_each { |item| new_array << yield(item) }
    new_array
  end

  def my_select
    new_array = []
    self.my_each { |item| new_array << item if yield(item) == true }
    new_array
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
  end
end

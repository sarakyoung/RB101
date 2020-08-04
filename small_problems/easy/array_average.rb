# add each element of the array together and divide by the length of the array.

def average(array)
  sum = 0
  array.each { |num| sum = sum + num }
  sum.to_f / array.length
end

puts average([1, 6]) 
puts average([1, 5, 87, 45, 8, 8]) 
puts average([9, 47, 23, 95, 16, 52]) 
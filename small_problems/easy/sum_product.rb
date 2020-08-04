# get user input for integer greater than zero
# get user input for operation (sum of product)
# calculate chosen operation on all numbers from 1 to chosen integer.
# -create an array from one to n
# -remove loop through the array, 
#   removing the last element each time and adding to the operation

answer = 0
operation_name = ''

def prompt(input)
  puts ">> #{input}:"
end



prompt("Please enter an integer greater than 0")
number = gets.chomp.to_i

prompt("Enter 's' to compute the sum or 'p' to compute the product")
operation = gets.chomp.downcase

array = (1..number).to_a

if operation == 's'
  answer = 0
  operation_name = 'sum'
  loop do
    answer += array.pop
    break if array.length == 0
  end
elsif operation == 'p'
  answer = 1
  operation_name == 'product'
  loop do
    answer *= array.pop
    break if array.length == 0
  end
end

puts "The #{operation_name} of the integers between 1 and #{number} is #{answer}. "
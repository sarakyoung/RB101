# create a loop that adds an alternating 1 or 0 onto a string.
# the number passed into the method will be the number of loops.

def stringy(num, start = 1)
  string = ''
  if start == 1
    loop do
      string << '1'
      break if string.length == num
      string << '0'
      break if string.length == num
    end
  elsif
    loop do
      string << '0'
      break if string.length == num
      string << '1'
      break if string.length == num
    end
  end
  string
end

puts stringy(6) == '101010'
puts stringy(9) == '101010101'
puts stringy(4) == '1010'
puts stringy(7, 0)
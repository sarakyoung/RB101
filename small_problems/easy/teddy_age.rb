# in method, generate random number between 20 and 200 and assign to variable age.
# print age

puts "Enter a name:"
name = gets.chomp
name = 'Teddy' if name.empty?

age = rand(20..200)
puts "#{name} is #{age} years old!"



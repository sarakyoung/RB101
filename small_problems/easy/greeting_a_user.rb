# get user name
# if user input ends in !
#   remove !
#   return HELLO NAME. WHY ARE WE SCREAMING?
# if user input does not end in !
#   return Hello name

print 'What is your name?  '
name = gets.chomp

if name.end_with?('!')
  name.chop!
  puts "HELLO #{name.upcase}. WHY ARE WE SCREAMING?"
else
  puts "Hello #{name}."
end
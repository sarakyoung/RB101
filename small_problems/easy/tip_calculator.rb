# get input for bill amount and tip percentage
# calculate tip and total bill amount
# display values

def valid_number?(input)
  (input.to_i.to_s == input || input.to_f.to_s == input)
end

bill_amount = ''
print "What is the bill? (for $100 input 100)  "
loop do
  bill_amount = gets.chomp
  break if valid_number?(bill_amount)
  puts "Please enter a valid number. Do not include $"
end

tip_percent = ''
print "What is the tip percentage? (for 20% input 20)  "
loop do
  tip_percent = gets.chomp
  break if valid_number?(tip_percent)
  puts "Please enter a valid number. Do not include %"
end

tip = bill_amount.to_f * (tip_percent.to_f/100)
total = bill_amount.to_f + tip

puts "The tip is $#{tip}."
puts "The total is $#{total}."
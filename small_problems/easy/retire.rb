# get current age and target retirement age
# find current year Time.now.year
# calculate years between current and retirement ages and add to current years.
# output will include current year, retirement year, and number of years until retirement.

print "What is your age?  "
current_age = gets.chomp.to_i

print "At what age would you like to retire?  "
retire_age = gets.chomp.to_i

yrs_to_retire = retire_age - current_age
current_year = Time.now.year
retire_year = current_year + yrs_to_retire

puts "It's #{current_year}. You will retire in #{retire_year}."
puts "You only have #{yrs_to_retire} years left!"
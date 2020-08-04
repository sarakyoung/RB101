# get length and width of a room in meters from user
# find room area in m^2
# convert m^2 to ft^2
# display room areas

SQFEET_TO_SQINCHES = 144
SQFEET_TO_SQCENTIMETER = 929.03

puts "Enter the length of the room in feet:"
length = gets.chomp

puts "Enter the width of the room in feet:"
width = gets.chomp

area_feet = length.to_f * width.to_f
area_inches = area_feet * SQFEET_TO_SQINCHES
area_centim = area_feet * SQFEET_TO_SQCENTIMETER

puts "The area of the room is #{area_feet.round(2)} square feet, " + \
      "#{area_inches} square inches and #{area_centim} square centimeters."

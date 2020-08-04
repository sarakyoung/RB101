# if boolean = false, return 0
# if boolean is true, return half of salary

def method(salary, eligible)
  eligible ? salary / 2 : 0
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000

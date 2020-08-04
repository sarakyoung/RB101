# for each number (1..99), check if odd.
# if odd puts

# (1..99).each { |n| puts n if n.odd? }

# 1.upto(99) { |n| puts n if n.odd? }

odds = (1..99).to_a.select { |n| n % 2 == 1 }
puts odds
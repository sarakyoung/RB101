# create empty hash
# check each item in the array
# if item is not in hash then add key and value = 1
# if item is in hash, then add one to the value

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

vehicle_count = {}

vehicles.each do |item|
  if vehicle_count.include?(item)
    vehicle_count[item] += 1
  else
    vehicle_count[item] = 1
  end
end


puts vehicle_count
# seperate string into words in array
# if word.length is >= 5, reverse the string
# join the array of strings back into one string.

def reverse_words(string)
  array = string.split(' ').each { |word| word.reverse! if word.length >= 5 }
  array.join(' ')
end


puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')      

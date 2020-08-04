# get inputs for loan amount, APR, loan duration.
# - verify each input is valid and in correct form
# - reprompt user if input is not valid

# perform calculation to convert APR to monthly interest rate in decimal form
# perform calculation to convert years to month for loan duration.
# perform calculation to find monthly payment
# print result

def prompt(words)
  puts ">> #{words}"
end

def valid_num?(input)
  (input.to_i.to_s == input || input.to_f.to_s == input) && input != '0'
end

prompt('Welcome to the loan calculator! What would you like to name this loan?')
loan_name = gets.chomp

prompt('What is the loan amount?')
loan_amount = ''
loop do
  loan_amount = gets.chomp
  break if valid_num?(loan_amount) == true
  puts "Please enter a valid number. (Do not precede with $)"
end

prompt('What is the APR?')
apr = ''
loop do
  apr = gets.chomp
  break if valid_num?(apr) == true
  puts "Please enter a valid number. (Do not use %)"
end

prompt('What is the loan duration in years?')
duration_years = ''
loop do
  duration_years = gets.chomp
  break if valid_num?(duration_years)
  puts "Please enter a valid number."
end

monthly_interest = (apr.to_f / 12) / 100
duration_months = duration_years.to_f * 12

monthly_payment = loan_amount.to_i *
                  (monthly_interest /
                  (1 - (1 + monthly_interest)**(-duration_months)))

puts "The monthly payment for #{loan_name} is #{monthly_payment.round(2)}."

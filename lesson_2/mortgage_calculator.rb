
def comma_killer(num_w_comma)
  parts = num_w_comma.split(',')
  full_number = ""
  parts.each { |part| full_number += part}
  full_number.to_f
end

def output_formatter(ugly_number)
  string_number = ugly_number.to_s
  ugly_number_array = string_number.split('.')
  whole_number = ugly_number_array[0]
  decimal = ugly_number_array[1]
  empty = []
  final = ""
  if whole_number.length <= 3
    return ugly_number
  else
    ones = whole_number.split(//).reverse!
    index = 0
    while index < ones.length
      if (index + 1) % 3 == 0
        empty << ones[index]
        empty << ',' unless index + 1 == ones.length
      else
        empty << ones[index]
      end
    index += 1
    end
  end
  empty.reverse!
  empty.each { |x| final += x }
  final += "." + decimal
  return final
end



puts "Welcome to Mortgage Calculator"

loop do

  print "Please enter loan amount --> $ "
  loan_amount = gets.chomp
  loan_amount = comma_killer(loan_amount)


  print "Please enter APR in decimals (Enter 5% interest as 0.05) --> "
  apr = gets.chomp.to_f

  puts 'How many years and months is the loan duration?'
  print 'Years --> '
  year_duration = gets.chomp.to_i
  print 'Months --> '
  month_duration = gets.chomp.to_i

  monthly_int_rate = apr / 12
  total_month_duration = month_duration + (year_duration * 12)
  monthly_payment = loan_amount * (monthly_int_rate / (1 -
                    (1 + monthly_int_rate)**(-total_month_duration)))

  puts "You will pay $#{output_formatter(monthly_payment.round(2))}" \
      " a month for a total of #{total_month_duration} payments."
  print "Another calculation? (Y/N) --> "
  repeat = gets.chomp.downcase
  break unless repeat.start_with?('y')
end
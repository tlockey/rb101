def display_sum_row(row)
  collection = create_collection(row)

  puts "The last row has the numbers #{collection.last}"
  puts "The sum of row #{row} is #{collection.last.sum}."
end

def create_collection(last_row)
  collection = []
  starting_number = 2
  (1..last_row).each do |current_row|
    collection << create_row(starting_number, current_row)
    starting_number = collection[-1][-1] + 2
  end
  collection
end

def create_row(starting_number, row_length)
  row = []
  current_number = starting_number
  loop do
    row << current_number
    current_number += 2
    break if row.size == row_length
  end
  row
end

loop do

print "Enter row number --> "
row = gets.chomp.to_i

display_sum_row(row)

puts "Again?(Y/N)"
again = gets.chomp.downcase
break unless again.start_with?('y')
end

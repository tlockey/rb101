=begin
Given this data structure, return a new array of the 
same structure but with the sub arrays being ordered 
(alphabetically or numerically as appropriate) 
in descending order.

input: nested array
output: nested array but with inners ordered

dang I forgot about map.
=end

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
new_arr = []

arr.each do |subarray|
  sorted = subarray.sort { |a,b| b <=> a }
  new_arr << sorted
end

p new_arr

# or

sorted = arr.map do |subarray|
          subarray.sort { |a,b| b <=> a }
         end
p sorted

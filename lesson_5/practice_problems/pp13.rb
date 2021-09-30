=begin
Given the following data structure, 
return a new array containing the same
sub-arrays as the original but ordered
logically by only taking into consideration
the odd numbers they contain.

input: array with three subarrays
output: new array, but in ascending order according to odd numbers
expected result: [[1, 8, 3], [1, 6, 7], [1, 4, 9]]
=end

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

sorted_arr = arr.sort_by do |subarray|
              subarray.reject {|x| x % 2 == 0}
            end

p sorted_arr == [[1, 8, 3], [1, 6, 7], [1, 4, 9]]


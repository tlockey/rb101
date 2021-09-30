=begin
Given this data structure write some code to return
an array which contains only the hashes where all 
the integers are even.

input: array with 3 hashes
output: new array with hashes with only even integers

1. Iterate over hashs in array
2. iterate over key-value pairs in hash
3. for each value, iterate over array
4. if all integers in all arrays are even
5. put hash in new array

=end

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

even_only = arr.select do |hash|
              hash.values.flatten.all?{|integer| integer.even?}
            end

p even_only
p arr

=begin
  Given the following data structure, 
  and without using the Array#to_h method, 
  write some code that will return a hash 
  where the key is the first item in each 
  sub array and the value is the second item.

input: an array of arrays
output: a hash where each subarray[0] = key, and subarray[1] = value


=end
arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

hsh = arr.each_with_object({}) do |subarray, hsh|
        hsh[subarray[0]] = subarray[1]
      end

# checking if result matches expected result:
p hsh == {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}


=begin
Given the following data structure and without 
modifying the original array, use the map method 
to return a new array identical in structure to 
the original but where the value of each integer 
is incremented by 1.

=end

data = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

def increment_data(data)
  data.map do |hash|
    new_hash = {}
    hash.each do |key, value|
      new_hash[key] = value + 1
    end
    new_hash
  end
end

p data
p increment_data(data)

